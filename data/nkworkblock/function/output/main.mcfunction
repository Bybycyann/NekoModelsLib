#预处理
function nkworkblock:output/tag with entity @s
#读取合成槽
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run function nkworkblock:recipes/read
#光标选取合成槽预处理
execute if score #click nkTemp matches 1 run scoreboard players set #remove nkTemp 1

#Shift 批量合成预处理
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz as @p[tag=nktemp] unless score #click nkTemp matches 1 run function nkworkblock:output/shift_click
#execute unless score #click nkTemp matches 1 run clear @s *[minecraft:custom_data~{tag:"output"}]

#消耗处理
data modify storage nktool:array input.source set from storage nktool:array output
data remove storage nktool:array output
function nkworkblock:output/remove
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify block ~ ~ ~ Items append from storage nktool:array output[]
#后处理
scoreboard players reset #click nkTemp
scoreboard players reset #arr nkTemp
#scoreboard players reset #remove nkTemp
execute unless score #click nkTemp matches 1 run tag @s remove nktemp
execute unless score #click nkTemp matches 1 run tag @e[tag=nkworkblock,tag=nktemp] remove nktemp
data remove storage nktool:array output
#重置进度触发器
advancement revoke @s only nkworkblock:output