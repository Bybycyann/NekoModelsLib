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