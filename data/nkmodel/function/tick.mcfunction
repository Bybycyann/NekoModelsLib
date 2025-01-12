#检测tag=nmo的标记实体, 并调用模型生成函数place.mcfunction
    execute as @e[type=minecraft:marker,tag=nmo] at @s run function nkmodel:main/0 with entity @s data

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