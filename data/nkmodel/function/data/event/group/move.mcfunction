#平移(move)变换
execute as @n[type=minecraft:interaction,tag=nmo] on attacker \
    if items entity @s weapon.offhand minecraft:iron_pickaxe[minecraft:custom_model_data=7810001] run \
    data modify entity @n[type=minecraft:marker,tag=nmoe] data.step_x set string entity @s Inventory[{Slot:-106b}].components."minecraft:custom_name" 1 -1
execute as @n[type=minecraft:interaction,tag=nmo] on attacker \
    if items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:custom_model_data=7810001] run \
    data modify entity @n[type=minecraft:marker,tag=nmoe] data.step_z set string entity @s SelectedItem.components."minecraft:custom_name" 1 -1

function nkmodel:data/event/move_x with entity @n[type=minecraft:marker,tag=nmoe] data
function nkmodel:data/event/move_z with entity @n[type=minecraft:marker,tag=nmoe] data

data remove entity @s data.step_x
data remove entity @s data.step_z