# NekoModelsLib

## 简介

NekoModelsLib 是一款轻量级Minecraft-Java版本的自定义模型支持库, 为方便玩家导入并使用自制的方块模型文件而编写. 在展示的基础上做了部分交互性拓展, 同时支持放置, 左键, 右键, 左键双击, 右键双击 5 种事件来源, 同时提供高自由度的事件创建. 在此数据包基础上, 玩家可以在原版中创建丰富多样的自定义家具包来为游戏中增添一些趣味, 或者以此包为基础联动其他数据包来创建更多丰富功能. 你可以利用它来制作神秘的祭坛, 功能性石碑, 特别宝箱等众多内容.

## 自定义数据存储结构

>  **声明**: 数据存储结构较大程度参考了 [CR-019](https://space.bilibili.com/85292644?spm_id_from=333.337.0.0) 的数据包 [DecoCreaterKit](https://www.mcmod.cn/class/14646.html).

### 索引(Index)

#### 注册

本包数据采取索引结构进行存储, 每个模型对应唯一的一个索引id, 在使用模型前需要对模型属性进行注册, 注册方法如下:

在数据包的 `.../nkmodel/function/data/model` 文件夹下创建模型对应的函数文件,写入以下内容:

```mcfunction
data modify storage nmo:index cask set value { <模型数据> } 
```

接着在 `.../nkmodel/tags/function` 目录下的文件 `model_reg.json` 中按格式写入上述模型注册函数

随后在游戏中通过 `/reload` 命令刷新数据包即可完成对应模型注册. 利用 `/data get storage nmo:index <索引id>` 可以对注册过的模型数据进行读取.

#### 使用

通过命令 `/function nkmodel:give {id:<索引id>}` 来获取对应模型的刷怪蛋.

#### 结构

自定义模型数据存储结构如下:

```snbt
#model(模型数据)
{
	#模板数据(作为模型数据的补充, 不使用时在后方填入null.)
	id:"<模型id>",
	template:"<模板id>",
	
	#自定义展示数据
	item:{
    	id:"<本体物品id>",
    	components:{
    		"minecraft:custom_model_data":"<模型映射值>",
    		"minecraft:item_name":"<模型名称>"
    	}
    },	
   
   #自定义交互数据
	event:{
        #双击事件启用判据
        dbl:< true/false >,
        #放置事件
        place:"< 事件id or group/事件组id >",
        #左键单击
        left_click:"< 事件id or group/事件组id >",
        #右键单击
        right_click:"< 事件id or group/事件组id >",
        #左键双击
        left_dblclick:"< 事件id or group/事件组id >",
        #右键双击
        right_dblclick:"< 事件id or group/事件组id >",
        #事件参数
        param:{
            place:{
            	attr:place, (*若调用事件为事件组则必填, 单一事件可不填)
            	( ...事件参数... )
            },
            lc:{
            	attr:lc, (*若调用事件为事件组则必填, 单一事件可不填)
            	( ...事件参数... )
            },
            rc:{
            	attr:rc, (*若调用事件为事件组则必填, 单一事件可不填)
            	( ...事件参数... )
            },
            ldc:{
            	attr:ldc, (*若调用事件为事件组则必填, 单一事件可不填)
            	( ...事件参数... )
            },
            rdc:{
            	attr:rdc, (*若调用事件为事件组则必填, 单一事件可不填)
            	( ...事件参数... )
            }
        }
    }
}
```

### 模板(Template)

#### 注册

模板的数据存储结构与上述结构一致, 但不含 `template` 项, 与模型数据类似的, 模板也采用索引结构进行存储.

在数据包的 `.../nkmodel/function/data/template` 文件夹下创建模型对应的函数文件,写入以下内容:

```mcfunction
data modify storage nmo:index cask set value { <模板数据> } 
```

接着在 `.../nkmodel/tags/function` 目录下的文件 `template_reg.json` 中按格式写入上述模板注册函数

随后在游戏中通过 `/reload` 命令刷新数据包即可完成对应模板注册. 利用 `/data get storage nmo:template <索引id>` 可以对注册过的模板数据进行读取.

#### 使用

通过在模型索引数据的 `template` 项后写入对应的模板id, 数据包会自动完成模板数据的调用, 在批量创建同类型的自定义模型时可以减少大量的重复性工作.

### 事件(Event)

> 详细了解内置事件内容请查阅项目Wiki

#### 结构

模型数据下提供了 6 个可供编辑的字段, 分别是 `dbl`, `left_click`, `right_click`, `left_dblclick`, `right_dblclick`, `param`. 下面分别介绍这 6 个字段的作用:

- <img src="https://zh.minecraft.wiki/images/Data_node_bool.svg?77754" alt='布尔型' title='布尔型' width='16' height='16'>**dbl**: (默认为 `false`) 若指定为true, 则数据包会对模型的双击事件进行判定

- <img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>**place**: 触发的事件或事件组. 若为单一事件则写入 `<事件id>`, 若为事件组则写入 `group/<事件组id>`

- <img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>**left_click**: 触发事件或事件组. 若为单一事件则写入 `<事件id>`, 若为事件组则写入 `group/<事件组id>`

- <img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>**right_click**: 触发事件或事件组. 若为单一事件则写入 `<事件id>`, 若为事件组则写入 `group/<事件组id>`

- <img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>**left_dblclick**: 触发事件或事件组. 若为单一事件则写入 `<事件id>`, 若为事件组则写入 `group/<事件组id>`

- <img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>**right_dblclick**: 触发事件或事件组. 若为单一事件则写入 `<事件id>`, 若为事件组则写入 `group/<事件组id>`

- <img src="https://zh.minecraft.wiki/images/Data_node_structure.svg?3a597" alt='NBT复合标签/JSON对象' title='NBT复合标签/JSON对象' width='16' height='16'>**param**: 存储所有类型事件的传入参数

  <details>
      <summary>param子内容</summary>
      <img src="https://zh.minecraft.wiki/images/Data_node_structure.svg?3a597" alt='NBT复合标签/JSON对象' title='NBT复合标签/JSON对象' width='16' height='16'>
      place: 放置事件参数<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>
      attr: 值与父级键名相同(place), 调用事件组(group)时必填, 单一事件可省略<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_any.svg?d406c" alt='任意类型' title='任意类型' width='16' height='16'>
      (xxx): 传入参数, 键名根据调用事件需求填写, 缺少参数会导致事件不能正常执行或事件组执行不完全<br>
      <img src="https://zh.minecraft.wiki/images/Data_node_structure.svg?3a597" alt='NBT复合标签/JSON对象' title='NBT复合标签/JSON对象' width='16' height='16'>
      lc: 左键交互事件参数<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>
      attr: 值与父级键名相同(lc), 调用事件组(group)时必填, 单一事件可省略<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_any.svg?d406c" alt='任意类型' title='任意类型' width='16' height='16'>
      (xxx): 传入参数, 键名根据调用事件需求填写, 缺少参数会导致事件不能正常执行或事件组执行不完全<br>
      <img src="https://zh.minecraft.wiki/images/Data_node_structure.svg?3a597" alt='NBT复合标签/JSON对象' title='NBT复合标签/JSON对象' width='16' height='16'>
      rc: 右键交互事件参数<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>
      attr: 值与父级键名相同(rc), 调用事件组(group)时必填, 单一事件可省略<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_any.svg?d406c" alt='任意类型' title='任意类型' width='16' height='16'>
      (xxx): 传入参数, 键名根据调用事件需求填写, 缺少参数会导致事件不能正常执行或事件组执行不完全<br>
      <img src="https://zh.minecraft.wiki/images/Data_node_structure.svg?3a597" alt='NBT复合标签/JSON对象' title='NBT复合标签/JSON对象' width='16' height='16'>
      ldc: 左键交互事件参数(
      <img src="https://zh.minecraft.wiki/images/Data_node_bool.svg?77754" alt='布尔型' title='布尔型' width='16' height='16'>
      dbl字段为 false 时可不填)<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>
      attr: 值与父级键名相同(ldc), 调用事件组(group)时必填, 单一事件可省略<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_any.svg?d406c" alt='任意类型' title='任意类型' width='16' height='16'>
      (xxx): 传入参数, 键名根据调用事件需求填写, 缺少参数会导致事件不能正常执行或事件组执行不完全<br>
      rdc: 左键交互事件参数(
      <img src="https://zh.minecraft.wiki/images/Data_node_bool.svg?77754" alt='布尔型' title='布尔型' width='16' height='16'>
      dbl字段为 false 时可不填)<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_string.svg?5cfa3" alt='字符串' title='字符串' width='16' height='16'>
      attr: 值与父级键名相同(rdc), 调用事件组(group)时必填, 单一事件可省略<br>
      --<img src="https://zh.minecraft.wiki/images/Data_node_any.svg?d406c" alt='任意类型' title='任意类型' width='16' height='16'>
      (xxx): 传入参数, 键名根据调用事件需求填写, 缺少参数会导致事件不能正常执行或事件组执行不完全<br>
  </details>
  
- <img src="https://zh.minecraft.wiki/images/Data_node_structure.svg?3a597" alt='NBT复合标签/JSON对象' title='NBT复合标签/JSON对象' width='16' height='16'>**attack**: 交互实体最后一次受到的攻击数据 (自读取, 修改无效)

  -- <img src="https://zh.minecraft.wiki/images/Data_node_int-array.svg?546e8" alt='整形数组' title='整型数组' width='16' height='16'>player: 攻击交互实体的玩家

  -- <img src="https://zh.minecraft.wiki/images/Data_node_long.svg?4a261" alt='长整型' title='长整型' width='16' height='16'>timestamp: 被攻击的时间

- <img src="https://zh.minecraft.wiki/images/Data_node_structure.svg?3a597" alt='NBT复合标签/JSON对象' title='NBT复合标签/JSON对象' width='16' height='16'>**interaction**: 交互实体最后一次受到的交互数据 (自读取, 修改无效)

  -- <img src="https://zh.minecraft.wiki/images/Data_node_int-array.svg?546e8" alt='整形数组' title='整型数组' width='16' height='16'>player: 与交互实体交互的玩家

  -- <img src="https://zh.minecraft.wiki/images/Data_node_long.svg?4a261" alt='长整型' title='长整型' width='16' height='16'>timestamp: 交互的时间

#### 组(Group)

为了能给自定义模型的交互事件提供更多的自由度, 本数据包提供了直接调用事件和调用事件组两种途径, 事件文件存放于包体的 `nkmodel/data/event` 目录下. 单一事件文件仅控制简单事件执行, 如播放音效, 产生粒子, 移动等. 对于复杂事件的处理采用事件组的形式在 `nkmodel/data/event/group` 目录下存储, 诸如破坏(break), 交互动画等需要多步骤或有附加条件的事件均在此处执行. 包体中已经内置了部分简单事件和事件组以供玩家调用, 这部分内容也会成为本数据包后面更新的重点内容, 下面将列出已经实装的事件相关效果和需求参数.

## 其他功能

### 调试

```mcfunction
/function nkmodel:debug
```

会在聊天框输出距离最近的自定义模型信息.

### 帮助

```mcfunction
/function nkmodel:help
```

来获取游戏内的帮助内容.
