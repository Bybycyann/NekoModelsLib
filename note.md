# NekoDatapack

> 数据包开发过程中不太成系统的记录, 项目初期使用, 成熟后移至README & 更新日志文件对项目内容进行管理和维护, 因此其内容可能与最终版本差异较大.

## End.自定义交互模型库(nkModelsLib)

### 模型展示

- 考虑到定点性生成问题,在使用自定义模型时, 可以选择使用 **展示框** or **刷怪蛋** 等方法来实现模型的放置
  本数据包采用刷怪蛋生成.
  `give @s cow_spawn_egg[entity_data={<model_data>}]`
  
- 借鉴 [CR-019](https://space.bilibili.com/85292644?spm_id_from=333.337.0.0) 的数据包 [DecoCreaterKit](https://www.mcmod.cn/class/14646.html) , 我们希望能够通过 [命令存储](https://zh.minecraft.wiki/w/%E5%91%BD%E4%BB%A4%E5%AD%98%E5%82%A8%E5%AD%98%E5%82%A8%E6%A0%BC%E5%BC%8F?variant=zh-cn) 来实现对自定义模型数据的管理以及调用, 在这里引入命令存储作为 **模型索引** `nmo:index` , 初步考虑其内数据的结构体为:

  ```snbt
  ##模型数据##
  
  {
  	#模板模型数据
  	template:"<模板id>",
  	
  	#自定义模型展示数据
  	item:{
      	id:"<本体物品id>",
      	components:{
      		"minecraft:custom_model_data":"<模型映射值>",
      		"minecraft:item_name":"<模型名称>"
      	}
      },	
     
     #自定义模型交互数据
      event:{ ...... }
  }
  ```
  其中 **模板(template)** 是为了方便写入参数而引入的,免去了重复写入固定参数的麻烦, 为了方便调用, 我们类比模型索引, 创建一个新命令存储 `nmo:template` 做为模板索引, 其结构如下:
  
  ```snbt
  ##模板数据##
  
  {
  	item:{ 模型展示模板数据 },
  	size:{ 模型平移缩放变换数据 },
  	event:{ 模型交互模板数据 }
  }
  ```
  
- 可通过指令 `data modify storage nmo:index <模型注册id> append value <模型数据>` 来将新模型注册进 `nmo:index` 中,  通过 `data get storage nmo:index <模型注册id>` 对注册的模型数据进行检查

- 接下来尝试获取生成对应模型的刷怪蛋, 刷怪蛋应该生成一个物品展示实体 `minecraft:item_display` 并考虑到破坏效果另外还需要再同样的地方生成一个交互实体 `minecraft:interaction` 来实现拆除等一系列交互行为.

  紧接着需要考虑如何将交互实体和展示实体相互绑定,或许在交互实体的执行函数中引入目标选择器 `@n[type=minecraft:item_display]` 会很方便实现?

- 根据索引数据结构, 我们需要将 `template`, `item` 以及 `event` 两组 SNBT 数据加入到 `minecraft:Item_display` 和 `minecraft:item_interaction` 的 SNBT 标签中, 并为了防止在防止自定义模型时由于玩家位置影响目标选择器目标混乱, 则在生成这些实体前可以先创建一个临时实体来存储索引数据, 后通过指令组来实现对临时实体所存储数据的调用和填充. 这里我们采用 [标记实体(Marker)](https://zh.minecraft.wiki/w/标记?variant=zh-cn) 来当做临时实体.

  > 关于标记实体(Marker)的特性在这做一定说明
  >
  > - 有独立的数据标签 `{ }`data 可写入**自定义标签**;
  > - 不占用体积, 不影响其他交互, 无法被除目标选择器外的一切交互选中.

  首先玩家可以通过指令获取带有特定模型索引数据的刷怪蛋

  `/give @s minecraft:cow_spawn_egg[entity_data={id:"minecraft:marker",Tags:["nmo"],data:{<index:模型注册id>}}]`

  `entity_data` 中 `Tags` 数据是方便后续目标选择器的确定, `data` 标签存储模型索引的id.

  在生成标记实体后可以通过以下指令组通过 **展示实体(display)** 来对自定义模型进行生成: 

  ```mcfunction
  ##数据包指令集结构##
  
  #>tick
  	#将Marker数据标签中data.index所包含的模型id传入nkmodel:place中
  	execute as @n[type=minecraft:marker,tag=nmo] at @s run \
  		function nkmodel:main/0 with entity @s data
  		
  #>0
  	#将data数据中的模型id数据替换为对应模型的索引数据
  	$data modify entity @s data set from storage nmo:index $(index)
  	#生成物品展示实体和交互实体
  	summon minecraft:item_display ~ ~ ~
  	summon minecraft:interaction ~ ~ ~
  	
  	#将Maeker数据标签中data.template所包含的自定义模型数据传入函数nkmodel:template中
  	function nkmodel:main/template with entity @s data
  		#>template
  		#将模板id所对应的item数据插入到物品展示实体的item键中
  		#$data modify entity @n[type=minecraft:item_display] item merge from \
  			storage nmo:template $(template).item
  		#$data modify entity @n[type=minecraft:item_display] transformation set from \
  			storage nmo:template $(template).size
  		#$data modify entity @s data.event set from storage nmo:template $(template).event
  	
  	#将Marker数据标签中自定义物品数据所对应的item数据值插入到物品展示实体的item键中
  	data modify entity @n[type=item_display] item merge from entity @s data.item
  ```


### 模型事件

#### 放置事件

- 故名思意, 放置事件即为模型在被放置时会触发的事件, 多为效果性事件. 先前通过 ` tick.mcfunction` 文件向`0.mcfunction` 文件中引入了Marker实体初始参数data, 并在该文件中对参数data进行了补全, 获得了事件属性 `event.place`, 该参数中存储着我们想要的放置事件的id, 借此我们可以再次利用宏参数, 将id导入一个新的文件并通过function语句对目标事件进行调用. 根据这个逻辑, 我们可以将主执行文件 `0.mcfunction` 该为:

  ```mcfunction
  #>tick
  #   execute as @n[type=minecraft:marker,tag=nmo] at @s run \
          function nkmodel:main/0 with entity @s data
  
  #补全Marker实体数据标签
  $data modify entity @s data set from storage nmo:index $(index)
  
  #生成模型
  summon minecraft:item_display ~ ~ ~
  summon minecraft:interaction ~ ~ ~
  
  #填充模板数据
  function nkmodel:main/template with entity @s data
      #>template
      #   $data modify entity @n[type=minecraft:item_display] item merge from \
      		storage nmo:template $(template).item
      #   $data modify entity @n[type=minecraft:item_display] transformation set from \
      		storage nmo:template $(template).size
      #	$data modify entity @s data.event set from storage nmo:template $(template).event
  
  #填充自定义模型数据
  data modify entity @n[type=item_display] item merge from entity @s data.item
  
  #放置事件
  execute if data entity @s data.event.place run \
  	function nkmodel:main/place with entity @s data.event
  	#>place
  	#	$function nkmodel:data/event/$(place)
  
  #模型交互事件由tick.mcfunction下的部分指令组执行
  
  #清空Marker的template和item数据
  data modify entity @s data set from entity @s data.event
  data modify entity @s Tags set value ["nmoe"]
  ```
  

#### 交互事件

- 通过上述指令组, 理论上已经可以成功实现对自定义模型的定点生成, 但些并不完善, 为了防止 `tick.mcfunction` 文件中 `function nkmodel:place with entity @n[type=minecraft:marker,tag=nmo] data` 的重复执行占用性能, 在模型生成结束后我们应该清除掉标记实体. 但在那之前, 为了拓展模型的交互性(最基础是要实现破坏功能), 我们仍需先创建 **交互实体(interaction)**. 关于 **事件属性(event)** 的结构设计, 我们做如下考虑:

  ```snbt
  ##事件数据##
  
  {
  	#双击事件启用判据
  	dbl:true/false,
  	#放置事件
  	place:"< 事件id >",
  	#左键单击
  	left_click:"< 事件id >",
  	#右键单击
  	right_click:"< 事件id >",
  	#左键双击
  	left_dblclick:"< 事件id >",
  	#右键双击
  	right_dblclick:"< 事件id >",
  	#事件参数
  	param:{
  		place:{ ...... },
  		lc:{ ...... },
  		rc:{ ...... },
  		ldc:{ ...... },
  		rdc:{ ...... }
  	}
  }
  ```
  
  根据上述事件结构, 我们可以构建如下指令组来实现对四种事件的分配:
  
  ```
  #>tick
  #交互事件
      #left_interaction
      execute as @e[type=minecraft:interaction,tag=nmo] at @s \
          if data entity @s attack run \
          data modify entity @n[type=minecraft:marker,tag=nmoe] data merge value {attr:1}
      #right_interaction
      execute as @e[type=minecraft:interaction,tag=nmo] at @s \
          if data entity @s interaction run \
          data modify entity @n[type=minecraft:marker,tag=nmoe] data merge value {attr:3}
      #next
      execute as @e[type=minecraft:interaction,tag=nmo] at @s \
          if data entity @n[type=minecraft:marker,tag=nmoe] data.attr run \
          function nkmodel:main/dblclick1
  
  #>dblclick1
  #单/双击判定1
      #防tick重复判定
      data modify entity @n[type=minecraft:marker,tag=nmoe] Tags set value ["nmoee"]
      data modify entity @s Tags set value ["nmoe"]
      #预处理
      data remove entity @s attack
      data remove entity @s interaction
      schedule function nkmodel:main/dblclick2 3.5 append
  
  #>dblclick2
  #单/双击判定2
      #ldc判定
      execute as @e[type=minecraft:interaction,tag=nmoe] at @s if data entity @s attack run \
              data modify entity @n[type=minecraft:marker,tag=nmoee] data.attr set value 2
      #rdc判定
      execute as @e[type=minecraft:interaction,tag=nmoe] at @s if data entity @s interaction run \
              data modify entity @n[type=minecraft:marker,tag=nmoee] data.attr set value 4
      #event执行
      execute as @e[type=minecraft:marker,tag=nmoee] run \
          function nkmodel:main/event with entity @s data
  
  #事件触发
      #lc
      $execute as @s at @s if entity @s[nbt={data:{attr:1}}] run \
          function nkmodel:data/event/$(left_click)
      #rc
      $execute as @s at @s if entity @s[nbt={data:{attr:3}}] run \
          function nkmodel:data/event/$(right_click)
      #ldc
      $execute as @s at @s if entity @s[nbt={data:{attr:2}}] run \
          function nkmodel:data/event/$(left_dblclick)
      #rdc
      $execute as @s at @s if entity @s[nbt={data:{attr:4}}] run \
          function nkmodel:data/event/$(right_dblclick)
  #重置
      data remove entity @n[type=minecraft:interaction,tag=nmoe] attack
      data remove entity @n[type=minecraft:interaction,tag=nmoe] interaction
      data remove entity @s data.attr
      data modify entity @n[type=minecraft:interaction,tag=nmoe] Tags set value ["nmo"]
      data modify entity @s Tags set value ["nmoe"]
  ```
  
  至此整个包体的结构便已编写完善
  
  后期内容移至[[Github]NekoModelsLib](https://github.com/Bybycyann/NekoModelsLib)更新

### 其他

- 关联模型实体.
- 附着 & 爆炸检测

### 新坑: 自定义工作方块(nkworkblock)

> **nkModelsLib**子功能库.

创建新的Storage索引 `nmo:container` 用来存储工作方块的数据信息, 其子结构(页)与木桶的方块实体数据结构一致, 具体结构见下文:

```SNBT
<索引注册id>: {											#根数据
	home:{													#存储工作方块的默认界面信息
		CustomName: "<界面名称>",			#控制主页面UI的文字信息
		Items: [{<槽位物品信息>}......],			 #管理界面的GUI, 通常含有GUI纹理模型和空模型填充不可用槽位
		components: {								   #仅存在于home页的数据, 在放置时填充进方块实体数据中存储...
			"minecraft:custom_data": {
				tag: "nkworkblock"					#nkworkblock-Block识别标签
			}
		}
	},
	<页面id>: {										   #子页面信息, ID自定
		CustomName: "<界面名称>"		   #控制子页面UI的文字信息
		Items:[{<槽位物品信息>}......],			#管理界面的GUI, 通常含有GUI纹理模型和空模型填充不可用槽位
	},
	......														 #其他子页面数据
}
```

采用容器交互判定的方式来绑定玩家和对应的Marker实体, 容器对应的Marker实体也承担了部分数据存储的作用, 其数据结构为:

```SNBT
{																   #根数据
	......															#其他实体标签
	Tags: ["nkworkblock"],							 #nkworkblock-Marker识别标签
	data: {														#自定义数据
		id: "<索引注册ID>",							   #用于在切换页面/破坏生成掉落物时候调用storage中的数据
		player: [],											   #使用容器的player的UUID列表
		page:"<容器当前界面id>"					#容器所处的页,默认为home
	}
}
```

关于容器GUI的交互功能, 结合组件 **custom_data** 来实现, 其结构为:

```SNBT
{
	tag:"nkgui",
	parent:"<容器根id>",
	type:"<交互事件类型>",
	button:"<交互事件id>"
}
```

关于配方:

配方文件存储于Storage `nmo:recipes` ,其数据结构如下:

```SNBT
<索引注册id>: [
	{recipe:[<配方列表数据>], result:{输出物品数据}
	......
]
```

#### 进度

- 容器的绑定与解绑, 确保玩家的点击事件仅对目标容器进行更新;
- 完善的防呆功能, 避免吞/刷物品BUG
- 支持容器内子页面与按钮事件自定义;
- 兼容Shift批量合成, 且兼容自定义物品堆叠上限;
- 合成栏 & 输出栏(仅有一个输出位)自适应, 高度自定义;
- 列表样合成表注册;
- 开关容器声音禁用;

#### 待完善

- recipes的main函数分支做整合
- 由于set数据填充问题导致爆炸产生的掉落物 count 被设置为 1
- 容器从home页切换到子页时回退玩家物品or缓存界面等待再次调用
- 如何阻止玩家用漏斗偷东西。
- 如何阻止玩家通过光标浮在物品上按Q的方式把物品丢出去。
- ~~合成物品点击占位符刷物品的bug~~
- ~~物品回退刷物品bug~~
- ~~再加一条若容器状态为闭合则清空player列表~~
- ~~容器关闭时回退到 home 页~~
- ~~如何阻止玩家把容器里作为“背景”的物品取出来。如何阻止玩家把容器破坏。~~
- ~~如何阻止玩家通过光标浮在物品上按F的方式把物品换到自己副手。~~
- ~~如何阻止玩家将不相干的物品放入容器中致使物品丢失。~~

## 新坑: 功能性函数库(nkToolKit)

### 射线投射-Raycast

>  调用例:
>
>  ```mcfunction
>  function nktool:raycast/0
>  execute at @n[tag=nkraycast] <附加条件> run ......
>  kill @n[tag=nkraycast]
>  ```

若成功在玩家视线射线5.1格范围内检索到方块则在目标位置生成 `tag=nkraycast` 的 Marker 实体, 可结合目标选择器选择该实体来实现间接选取目标方块.

### 列表重组-List regroup

> 调用例:
>
> ```mcfunction
> #basic函数 --处理最基本的数据剔除
> data modify storage nktool:array input.source set ......
> data modify storage nktool:array input.condition set ......
> scoreboard players set #regroup nkTemp <分支值>						  #0为剔除元素, 1为保留元素
> function nktool:regroup/0
> data modify <存储目标> set from storage nktool:array output			#output数据覆写
> data remove storage nktool:array output
> 
> #container函数 --对容器中符合tag条件的物品数据进行筛除
> data modify storage nktool:array input.source set ......					  #容器的Items列表
> data modify storage nktool:array input.condition set ......					#该项应输入目标tag
> scoreboard players set #arr nkTemp <分支值>								 #1则调用container函数
> scoreboard players set #regroup nkTemp <分支值>						 #0为剔除元素, 1为保留元素
> function nktool:regroup/0
> ......																										#处理输出列表
> data remove storage nktool:array output
> ```

创建storage `nktool:array` 用来存储输出列表 `output`, 源列表 `source`, 目标值 `condition` 和逻辑值 `temp`, 其数据结构如下:

```SNBT
{
	input: {
		source: <源列表>,
		condition: <目标值>,
		temp: <逻辑值>
	},
	output: <返回列表>
}
```

### 列表比对-List comp

> 调用例:
>
> ```mcfunction
> 
> ```

创建Storage `nktool:array` 用来存储输出列表 `output`, 源列表 `source`, 对照列表 `after` 和逻辑值 `temp`, 其数据结构如下:

```SNBT
{
	input: {
		source: <源列表>,
		after:<对照列表>,
		temp: <逻辑值>
	},
	output: <返回列表>
}
```

### 极值-Extreme

> 调用例:
>
> ```mcfunction
> data modify storage nktool:array input.source set ......
> data modify storage nktool:array input.type set value <max/min>
> function nktool:extreme/0
> ......
> scoreboard players reset #temp nkTemp
> scoreboard players reset #arr nkTemp
> scoreboard players reset #extreme nkTemp
> ```
>

创建Storage `nktool:array` 用来存储输源列表 `source` 和运算类型 `type`, 因运算多使用计分板故输出值也采用计分板输出, 结果存储在 `#extreme nkTemp` 中

```SNBT
{
	input:{
		source: <源列表>,
		type: <max or min>
	}
}
```
