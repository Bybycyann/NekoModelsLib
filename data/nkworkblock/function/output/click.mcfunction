#预处理
tag @s add nktemp
$execute as @e[tag=nkworkblock] if data entity @s {data:{player:[$(UUID)]}} run tag @s add nktemp
#鼠标选取特征变量
scoreboard players set #click nkTemp 1
#物品迁移
item replace entity @s player.crafting.0 from entity @s container.0
item replace entity @s container.0 from entity @s player.cursor
    #通过进度触发器调用output/main
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run item replace block ~ ~ ~ container.0 from entity @p[tag=nktemp] container.0
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data remove block ~ ~ ~ Items[{Slot:0b}].components."minecraft:custom_data".tag
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz store result score #temp nkTemp run data get block ~ ~ ~ Items[{Slot:0b}].components."minecraft:custom_data"
execute if score #temp nkTemp matches 0 as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data remove block ~ ~ ~ Items[{Slot:0b}].components."minecraft:custom_data"
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run item replace entity @p[tag=nktemp] player.cursor from block ~ ~ ~ container.0
item replace entity @s container.0 from entity @s player.crafting.0
item replace entity @s player.crafting.0 with minecraft:air
#容器界面刷新
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify block ~ ~ ~ Items append from storage nmo:container furniture_crafting_table.home.Items[]
#后处理
#tag @s remove nktemp
#tag @e[tag=nkworkblock,tag=nktemp] remove nktemp
scoreboard players reset #temp nkTemp
scoreboard players reset #click nkTemp