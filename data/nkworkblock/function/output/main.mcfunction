#预处理
function nkworkblock:output/tag with entity @s
#光标选取 单次合成处理
execute if score #click nkTemp matches 1 at @n[tag=nkworkblock,tag=nktemp] align xyz run function nkworkblock:output/m_click
#读取合成槽
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run function nkworkblock:recipes/read
#Shift 批量合成处理
execute unless score #click nkTemp matches 1 as @e[tag=nkworkblock,tag=nktemp] at @s align xyz as @p[tag=nktemp] run function nkworkblock:output/m_shift
#消耗处理
data modify storage nktool:array input.source set from storage nktool:array output
data remove storage nktool:array output
function nkworkblock:output/remove
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify block ~ ~ ~ Items append from storage nktool:array output[]
#容器界面刷新
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify block ~ ~ ~ Items append from storage nmo:container furniture_crafting_table.home.Items[]
#后处理
execute unless score #click nkTemp matches 1 run tag @s remove nktemp
execute unless score #click nkTemp matches 1 run tag @e[tag=nkworkblock,tag=nktemp] remove nktemp
scoreboard players reset #click nkTemp
scoreboard players reset #arr nkTemp
scoreboard players reset #temp2 nkTemp
scoreboard players reset #comp nkTemp
scoreboard players reset #temp2 nkTemp
scoreboard players reset #extreme nkTemp
scoreboard players reset #count nkTemp
scoreboard players reset #stack nkTemp
scoreboard players reset #openslot nkTemp
scoreboard players reset #give nkTemp
scoreboard players reset #remove nkTemp
data remove storage nktool:array output
data remove storage nktool:array container
data remove storage nmo:temp recipe
#重置进度触发器
advancement revoke @s only nkworkblock:output