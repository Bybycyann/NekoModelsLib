#>nkmodel/tick
#模型生成 & 放置事件   
    execute as @e[type=minecraft:marker,tag=nmo] at @s run \
        function nkmodel:main/0 with entity @s data
#交互事件
    #left_interaction
    execute as @e[type=minecraft:interaction,tag=nmo,tag=!nktemp] at @s \
        if data entity @s attack run \
        data modify entity @n[type=minecraft:marker,tag=nmoe,tag=!nktemp] data merge value {attr:1}
    #right_interaction
    execute as @e[type=minecraft:interaction,tag=nmo,tag=!nktemp] at @s \
        if data entity @s interaction run \
        data modify entity @n[type=minecraft:marker,tag=nmoe,tag=!nktemp] data merge value {attr:3}
    #next
    execute as @e[type=minecraft:interaction,tag=nmo,tag=!nktemp] at @s \
        if data entity @n[type=minecraft:marker,tag=nmoe,tag=!nktemp] data.attr run \
        function nkmodel:main/dblclick1
#事件补充内容
    #清除骑乘媒介(..0.7是试出来的,本来0.6也可以的,但是换了个世界出BUG就给调成0.7了)
    execute as @e[tag=nmoride] at @s unless entity @a[distance=..0.7] run kill @s
#>nkmodel/main/0	
#补全Marker实体数据标签
	$data modify entity @s data set from storage nmo:index $(index)
#生成展示 & 交互实体
	summon minecraft:item_display ~ ~ ~ {Tags:["nmo"]}
	summon minecraft:interaction ~ ~ ~ {Tags:["nmo"]}
#填充模型数据
    #填充模板数据
	function nkmodel:main/template with entity @s data
    #>nkmodel/main/template
    $data modify entity @n[type=minecraft:item_display] transformation set from \
        storage nmo:template $(template).transformation
    $data modify entity @n[type=minecraft:item_display] {} set from \
        storage nmo:template $(template).display
    $data modify entity @s data.event merge from storage nmo:template $(template).event
    #填充自定义数据
	data modify entity @n[type=item_display,tag=nmo] item merge from entity @s data.item
#模型事件
	#放置事件
	execute if data entity @s data.event.place run \
		function nkmodel:main/place with entity @s data.event
        #>nkmodel/main/place
        $function nkmodel:data/event/$(place) with entity @s data.event.param.place
    #交互事件
        #>nkmodel/main/dblclick1
        #单/双击判定1
        #防tick重复判定
        tag @n[type=minecraft:marker,tag=nmoe] add nktemp
        tag @s add nktemp
        #预处理
        data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attack set from entity @s attack
        data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.interaction set from entity @s interaction
        data remove entity @s attack
        data remove entity @s interaction
        schedule function nkmodel:main/dblclick2 3 append
        #>nkmodel/main/dblclick2
        #单/双击判定2
            #ldc判定
            execute as @e[type=minecraft:interaction,tag=nmo,tag=nktemp,tag=dbl] at @s if data entity @s attack run \
                    data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attr set value 2
            #rdc判定
            execute as @e[type=minecraft:interaction,tag=nmo,tag=nktemp,tag=dbl] at @s if data entity @s interaction run \
                    data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attr set value 4
            #补全交互信息
            execute as @e[type=minecraft:marker,tag=nmoe,tag=nktemp] at @s run \
                data modify entity @n[type=minecraft:interaction,tag=nmo] attack set from entity @s data.attack
            execute as @e[type=minecraft:marker,tag=nmoe,tag=nktemp] at @s run \
                data modify entity @n[type=minecraft:interaction,tag=nmo] interaction set from entity @s data.interaction
            #event执行
            execute as @e[type=minecraft:marker,tag=nmoe,tag=nktemp] run \
                function nkmodel:main/event with entity @s data
        #>nkmodel/main/event
        #事件触发
            #lc
            $execute as @s at @s if entity @s[nbt={data:{attr:1}}] run \
                function nkmodel:data/event/$(left_click) with entity @s data.param.lc
            $execute as @s at @s if entity @s[nbt={data:{attr:3}}] run \
                function nkmodel:data/event/$(right_click) with entity @s data.param.rc
            #ldc
            $execute as @s at @s if entity @s[nbt={data:{attr:2}}] run \
                function nkmodel:data/event/$(left_dblclick) with entity @s data.param.ldc
            #rdc
            $execute as @s at @s if entity @s[nbt={data:{attr:4}}] run \
                function nkmodel:data/event/$(right_dblclick) with entity @s data.param.rdc
        #属性重置
            data remove entity @n[type=minecraft:interaction,tag=nmo,tag=nktemp] attack
            data remove entity @n[type=minecraft:interaction,tag=nmo,tag=nktemp] interaction
            data remove entity @s data.attr
            tag @n[type=minecraft:interaction,tag=nmo,tag=nktemp] remove nktemp
            tag @s remove nktemp
#双击启用判定
	execute if data entity @s {data:{event:{dbl:true}}} run tag @n[type=interaction,tag=nmo] add dbl
#工作方块判定
	execute if data entity @s {data:{workblock:true}} run kill @n[type=minecraft:interaction,tag=nmo]
	execute if data entity @s {data:{workblock:true}} run kill @n[type=minecraft:marker,tag=nmo]
	execute if data entity @s {data:{workblock:true}} run function nkworkblock:main/0
#清空Marker的template和item数据
	data modify entity @s data.event.id set string entity @s data.id
	data modify entity @s data set from entity @s data.event
	data modify entity @s Tags set value ["nmoe"]