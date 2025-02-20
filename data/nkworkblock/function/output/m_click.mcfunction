#remove tag:output
item replace block ~ ~ ~ container.0 from entity @s player.cursor
data remove block ~ ~ ~ Items[{Slot:0b}].components."minecraft:custom_data".tag
execute store result score #temp2 nkTemp run data get block ~ ~ ~ Items[{Slot:0b}].components."minecraft:custom_data"
execute if score #temp2 nkTemp matches 0 run data remove block ~ ~ ~ Items[{Slot:0b}].components."minecraft:custom_data"
#合成槽 add tag-openslot
execute as @e[tag=nkworkblock,tag=nktemp] run function nkworkblock:openslot/0 with entity @s data
#data get 输出槽
data modify storage nktool:array input.source set from block ~ ~ ~ Items
data modify storage nktool:array input.condition set value "nkgui"
scoreboard players set #arr nkTemp 1
scoreboard players set #output nkTemp 0
function nktool:regroup/0
scoreboard players set #arr nkTemp 1
data modify storage nktool:array input.source set from storage nktool:array output
data modify storage nktool:array input.condition set value "nkopenslot"
function nktool:regroup/0
data remove storage nktool:array output[{Slot:0b}]
#合成槽 remove tag-openslot
execute as @e[tag=nkworkblock,tag=nktemp] run function nkworkblock:openslot/1 with entity @s data
#output == air?
execute store result score #temp2 nkTemp run data get storage nktool:array output
    execute if score #temp2 nkTemp matches 0 run scoreboard players set #remove nkTemp 1
    execute if score #temp2 nkTemp matches 0 run return run item replace entity @s player.cursor from block ~ ~ ~ container.0
#input == output?
execute store success score #temp2 nkTemp run data modify block ~ ~ ~ Items[{Slot:0b}].id set from storage nktool:array output[0].id
execute if score #temp2 nkTemp matches 0 run scoreboard players add #comp nkTemp 1
execute store success score #temp2 nkTemp run data modify block ~ ~ ~ Items[{Slot:0b}].components set from storage nktool:array output[0].components
execute if score #temp2 nkTemp matches 0 run scoreboard players add #comp nkTemp 1
    execute unless score #comp nkTemp matches 2 run data modify storage nktool:array output[0].Slot set value 0b
    execute unless score #comp nkTemp matches 2 run data modify block ~ ~ ~ Items[{Slot:0b}] set from storage nktool:array output[0]
    execute unless score #comp nkTemp matches 2 run return run item replace entity @s player.cursor from block ~ ~ ~ container.0
#input-stack max?
item modify block ~ ~ ~ container.0 {function:set_count,count:100}
execute store success score #temp2 nkTemp run data modify block ~ ~ ~ Items[{Slot:0b}].count set from storage nktool:array output[0].count
    execute if score #temp2 nkTemp matches 0 run return run item replace entity @s player.cursor from block ~ ~ ~ container.0
#add count
scoreboard players set #remove nkTemp 1
execute store result score #temp2 nkTemp run data get block ~ ~ ~ Items[{Slot:0b}].count
scoreboard players add #temp2 nkTemp 1
execute store result block ~ ~ ~ Items[{Slot:0b}].count int 1 run scoreboard players get #temp2 nkTemp
item replace entity @s player.cursor from block ~ ~ ~ container.0