#检测tag=nmo的标记实体, 并调用模型生成函数0.mcfunction
execute as @e[type=minecraft:marker,tag=nmo] at @s run function nkmodel:main/0 with entity @s data

#交互事件
    #left_interaction
    execute as @e[type=minecraft:interaction,tag=nmo,tag=!nktemp] at @s \
        if entity @a[distance=..5.5] \
        if data entity @s attack run \
        data modify entity @n[type=minecraft:marker,tag=nmoe,tag=!nktemp] data merge value {attr:1}
    #right_interaction
    execute as @e[type=minecraft:interaction,tag=nmo,tag=!nktemp] at @s \
        if entity @a[distance=..5.5] \
        if data entity @s interaction run \
        data modify entity @n[type=minecraft:marker,tag=nmoe,tag=!nktemp] data merge value {attr:3}
    #next
    execute as @e[type=minecraft:interaction,tag=nmo,tag=!nktemp] at @s \
        if entity @a[distance=..5.5] \
        if data entity @n[type=minecraft:marker,tag=nmoe,tag=!nktemp] data.attr run \
        function nkmodel:main/dblclick1

#事件补充内容
    #清除骑乘媒介
    execute as @e[tag=nmoride] at @s unless entity @a[distance=..0.7] run kill @s