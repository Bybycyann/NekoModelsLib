execute as @e[type=minecraft:interaction,tag=nmo,tag=nktemp,tag=dbl] at @s if data entity @s attack run data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attr set value 2
execute as @e[type=minecraft:interaction,tag=nmo,tag=nktemp,tag=dbl] at @s if data entity @s interaction run data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attr set value 4
execute as @e[type=minecraft:marker,tag=nmoe,tag=nktemp] run function nkmodel:main/event with entity @s data