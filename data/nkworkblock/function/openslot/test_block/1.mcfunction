data remove block ~ ~ ~ Items[{Slot:11b}].components."minecraft:custom_data".tag
execute store success score #openslot nkTemp run data modify storage nmo:temp openslot merge from block ~ ~ ~ Items[{Slot:11b}].components."minecraft:custom_data"
execute if score #openslot nkTemp matches 0 run data remove block ~ ~ ~ Items[{Slot:11b}].components."minecraft:custom_data"
data remove storage nmo:temp openslot
scoreboard players reset #openslot nkTemp

data remove block ~ ~ ~ Items[{Slot:12b}].components."minecraft:custom_data".tag
execute store success score #openslot nkTemp run data modify storage nmo:temp openslot merge from block ~ ~ ~ Items[{Slot:12b}].components."minecraft:custom_data"
execute if score #openslot nkTemp matches 0 run data remove block ~ ~ ~ Items[{Slot:12b}].components."minecraft:custom_data"
data remove storage nmo:temp openslot
scoreboard players reset #openslot nkTemp

data remove block ~ ~ ~ Items[{Slot:13b}].components."minecraft:custom_data".tag
execute store success score #openslot nkTemp run data modify storage nmo:temp openslot merge from block ~ ~ ~ Items[{Slot:13b}].components."minecraft:custom_data"
execute if score #openslot nkTemp matches 0 run data remove block ~ ~ ~ Items[{Slot:13b}].components."minecraft:custom_data"
data remove storage nmo:temp openslot
scoreboard players reset #openslot nkTemp