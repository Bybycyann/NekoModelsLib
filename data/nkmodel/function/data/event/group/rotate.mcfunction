#旋转(rotate)变换
execute as @n[type=minecraft:interaction,tag=nmo] on target \
    if items entity @s weapon.offhand minecraft:iron_pickaxe[minecraft:custom_model_data=7810001] run \
    data modify entity @n[type=minecraft:marker,tag=nmoe] data.degree_x set string entity @s Inventory[{Slot:-106b}].components."minecraft:custom_name" 1 -1
execute as @n[type=minecraft:interaction,tag=nmo] on target \
    if items entity @s weapon.mainhand minecraft:iron_pickaxe[minecraft:custom_model_data=7810001] run \
    data modify entity @n[type=minecraft:marker,tag=nmoe] data.degree_y set string entity @s SelectedItem.components."minecraft:custom_name" 1 -1

execute as @n[type=item_display,tag=nmo] at @s run \
    function nkmodel:data/event/rotate_x with entity @n[type=minecraft:marker,tag=nmoe] data
execute as @n[type=item_display,tag=nmo] at @s run \
    function nkmodel:data/event/rotate_y with entity @n[type=minecraft:marker,tag=nmoe] data

data remove entity @s data.degree_x
data remove entity @s data.degree_y