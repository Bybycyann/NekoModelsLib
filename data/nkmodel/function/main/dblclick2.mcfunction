#单/双击判定2
    #ldc判定
    execute as @e[type=minecraft:interaction,tag=nmo,tag=nktemp] at @s if data entity @s attack run \
            data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attr set value 2
    #rdc判定
    execute as @e[type=minecraft:interaction,tag=nmo,tag=nktemp] at @s if data entity @s interaction run \
            data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attr set value 4
    #event执行
    execute as @e[type=minecraft:marker,tag=nmoe,tag=nktemp] run \
        function nkmodel:main/event with entity @s data