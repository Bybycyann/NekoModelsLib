#输出物数据转存
data modify storage nmo:temp recipe.id set from entity @s Inventory[{components:{"minecraft:custom_data":{tag:output}}}].id
data modify storage nmo:temp recipe.components set from entity @s Inventory[{components:{"minecraft:custom_data":{tag:output}}}].components
data remove storage nmo:temp recipe.components."minecraft:custom_data".tag
execute store result score #temp2 nkTemp run data get storage nmo:temp recipe.components."minecraft:custom_data"
execute if score #temp2 nkTemp matches 0 run data remove storage nmo:temp recipe.components."minecraft:custom_data"
#取合成栏材料count最小值于 #extreme nkTemp
data modify storage nktool:array input.temp set from storage nktool:array output
function nkworkblock:recipes/count_list
data modify storage nktool:array input.type set value min
function nktool:extreme/0
#读取单位合成数于 #count nkTemp, 物品堆叠上限于 #stack nkTemp (支持自定义堆叠范围1..99)
data modify block ~ ~ ~ Items[{Slot:18b}].id set from entity @s Inventory[{components:{"minecraft:custom_data":{tag:output}}}].id
#data modify block ~ ~ ~ Items[{Slot:18b}].components set from entity @s Inventory[{components:{"minecraft:custom_data":{tag:output}}}].components
data modify block ~ ~ ~ Items[{Slot:18b}].count set from entity @s Inventory[{components:{"minecraft:custom_data":{tag:output}}}].count
execute store result score #count nkTemp run data get block ~ ~ ~ Items[{Slot:18b}].count
item modify block ~ ~ ~ container.18 {function:set_count,count:100}
execute store result score #stack nkTemp run data get block ~ ~ ~ Items[{Slot:18b}].count
#删除取出物腾出背包空间
clear @s *[minecraft:custom_data~{tag:"output"}]
#读取玩家背包空槽位数于 #openslot nkTemp
data modify storage nktool:array container set from entity @s Inventory
data remove storage nktool:array container[{Slot:-106b}]
data remove storage nktool:array container[{Slot:100b}]
data remove storage nktool:array container[{Slot:101b}]
data remove storage nktool:array container[{Slot:102b}]
data remove storage nktool:array container[{Slot:103b}]
execute store result score #temp2 nkTemp run data get storage nktool:array container
scoreboard players set #openslot nkTemp 36
scoreboard players operation #openslot nkTemp -= #temp2 nkTemp
#运算结果存储于 #remove nkTemp
scoreboard players operation #openslot nkTemp *= #stack nkTemp
scoreboard players operation #openslot nkTemp /= #count nkTemp
execute if score #extreme nkTemp > #openslot nkTemp run execute store result score #extreme nkTemp run scoreboard players get #openslot nkTemp
execute store result score #remove nkTemp run scoreboard players get #extreme nkTemp
#输出
execute store result score #give nkTemp run scoreboard players get #remove nkTemp
function nkworkblock:output/give
#容器界面刷新
data modify block ~ ~ ~ Items append from storage nmo:container furniture_crafting_table.home.Items[]
#后处理
scoreboard players reset #temp2 nkTemp
scoreboard players reset #extreme nkTemp
scoreboard players reset #count nkTemp
scoreboard players reset #stack nkTemp
scoreboard players reset #openslot nkTemp
scoreboard players reset #give nkTemp
data remove storage nktool:array container