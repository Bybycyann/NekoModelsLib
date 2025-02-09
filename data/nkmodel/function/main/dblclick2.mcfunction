#单/双击判定2
    #ldc判定
    execute as @e[type=minecraft:interaction,tag=nmo,tag=nktemp,tag=dbl] at @s \
        if data entity @s attack run \
        data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attr set value 2
    #rdc判定
    execute as @e[type=minecraft:interaction,tag=nmo,tag=nktemp,tag=dbl] at @s \
        if data entity @s interaction run \
         data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attr set value 4
    #补全交互信息
    execute as @e[type=minecraft:marker,tag=nmoe,tag=nktemp] at @s run \
        data modify entity @n[type=minecraft:interaction,tag=nmo] attack set from entity @s data.attack
    execute as @e[type=minecraft:marker,tag=nmoe,tag=nktemp] at @s run \
        data modify entity @n[type=minecraft:interaction,tag=nmo] interaction set from entity @s data.interaction
    #event执行
    execute as @e[type=minecraft:marker,tag=nmoe,tag=nktemp] run \
        function nkmodel:main/event with entity @s data