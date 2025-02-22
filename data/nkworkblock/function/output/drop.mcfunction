#丢弃事件特征变量
scoreboard players set #click nkTemp 2
#remove tag-output
data remove entity @s Item.components."minecraft:custom_data".tag
execute store result score #temp nkTemp run data get entity @s Item.components."minecraft:custom_data"
execute if score #temp nkTemp matches 0 run data remove entity @s Item.components."minecraft:custom_data"
scoreboard players reset #temp nkTemp
#消耗数
scoreboard players set #remove nkTemp 1
#调用output/main
execute as @s on origin run function nkworkblock:output/main