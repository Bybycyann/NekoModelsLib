$execute as @e[type=minecraft:marker,tag=nkworkblock] if data entity @s {data:{player:[$(UUID)]}} run tag @s add nktemp
execute as @e[type=minecraft:marker,tag=nkworkblock,tag=nktemp] at @s align xyz run function nkworkblock:button/reload2 with entity @s data
tag @e[type=minecraft:marker,tag=nkworkblock,tag=nktemp] remove nktemp