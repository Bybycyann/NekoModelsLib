#取合成栏材料count最小值于 #extreme nkTemp
data modify storage nktool:array input.temp set from storage nktool:array output
function nkworkblock:recipes/count_list
data modify storage nktool:array input.type set value min
function nktool:extreme/0
#读取玩家背包空槽位数于 #openslot nkTemp
data modify storage nktool:array container set from entity @s Inventory
data remove storage nktool:array container[{Slot:-106b}]
data remove storage nktool:array container[{Slot:100b}]
data remove storage nktool:array container[{Slot:101b}]
data remove storage nktool:array container[{Slot:102b}]
data remove storage nktool:array container[{Slot:103b}]
execute store result score #temp nkTemp run data get storage nktool:array container
scoreboard players set #openslot nkTemp 36
scoreboard players operation #openslot nkTemp -= #temp nkTemp
#取两者间最小值作为 #remove nkTemp
execute if score #extreme nkTemp > #openslot nkTemp run execute store result score #extreme nkTemp run scoreboard players get #openslot nkTemp
execute store result score #remove nkTemp run scoreboard players get #extreme nkTemp
#后处理
scoreboard players reset #extreme nkTemp
scoreboard players reset #openslot nkTemp
scoreboard players reset #temp nkTemp