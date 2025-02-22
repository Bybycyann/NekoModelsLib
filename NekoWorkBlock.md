# NekoWorkBlock

## 简介

NekoWorkBlock 是一款面向 Minecraft-Java 高版本编写的一个自定义工作方块支持数据包. 包体建立了一个通用方法, 开发者仅需通过编辑部分数据文件来创造出高自由度且逻辑完善的工作方块供模组使用.

本数据包为 NekoModelsLib 的子包, 该包仅为本包提供方块模型支持.

## 自定义工作方块数据存储

### 模型数据值

管理方块的自定义模型, 其数据存储于Storage **nmo:index ** 中

```SNBT
#>data/nkworkblock/function/data/model/<注册ID>

{
	id:<注册ID>,
    template:workblock,
    workblock:true,
    display:{
        item:{
            id:"minecraft:cow_spawn_egg",
            components:{
                "minecraft:custom_model_data":<模型映射值>,
                "minecraft:item_name":'<模型名称>'
            }
        }
    }
}
```

#### 注册

xxx

### GUI数据值

该项目在存档内以Storage **nmo:container** 存储

```SNBT
#>data/nkworkblock/function/data/container/<注册ID>

<索引注册ID>: {											#根数据
	home:{													#存储工作方块的默认界面信息
		CustomName: "<界面名称>",			#控制主页面UI的文字信息
		Items: [{<槽位物品信息>}......],			 #管理界面的GUI, 通常含有GUI纹理模型和空模型填充不可用槽位
		components: {								   #仅存在于home页的数据, 在放置时填充进方块实体数据中存储...
			"minecraft:custom_data": {
				tag: "nkworkblock"					#nkworkblock-Block识别标签
			}
		}
	},
	<页面ID>: {										   #子页面信息, ID自定
		Items:[{<槽位物品信息>}......],			#管理界面的GUI, 通常含有GUI纹理模型和空模型填充不可用槽位
	},
	......														 #其他子页面数据
}
```

#### 注册

xxx

#### - 交互按键

该项目由占位符的 **custom_data** 组件管理, 控制交互时的行为

```SNBT
{
	tag:"nkgui",
	parent:"<容器根ID>",
	page:"<目标页ID>"
}
```

### 合成表数据

用于存储工作台的**有序合成**配方, 相关数据存储于Storage **nmo:recipes** 中

```SNBT
#>data/nkworkblock/function/data/recipes/<注册ID>

<索引注册id>: [
	#首项数据必须为如下元素, 用来代表空对象
	{
		recipe:[],
		result:{
            count:1,id:"minecraft:paper",
            components:{"minecraft:custom_data":{tag:"nkgui",result:null},"minecraft:hide_tooltip":{},"minecraft:item_model":"minecraft:air"}
        }
	},
	{recipe:[<配方列表数据>], result:{输出物品数据},
	......
]
```

#### 注册

xxx

### 方块实体扩充数据值

本质是对方块实体数据的一个扩充, 存储于方块坐标 ~0.5 ~ ~0.5 处的 Marker 实体中

无需注册.

```SNBT
{																   #根数据
	......															#其他实体标签
	Tags: ["nkworkblock"],							 #nkworkblock-Marker识别标签
	data: {														#自定义数据
		id: "<索引注册ID>",							   #用于在切换页面/破坏生成掉落物时候调用storage中的数据
		player: [],											   #使用容器的player的UUID列表
		page:"<容器当前界面id>",					#容器所处的页,默认为home
		temp:[]												  #切换页面时缓存合成槽
	}
}
```
