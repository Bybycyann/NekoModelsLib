#预处理
tag @s add nktemp
$execute as @e[tag=nkworkblock] if data entity @s {data:{player:[$(UUID)]}} run tag @s add nktemp
#遍历容器并回退物品
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify storage nktool:array input.source set from block ~ ~ ~ Items
data modify storage nktool:array input.remove set value "nkgui"
scoreboard players set #arr nkTemp 1
function nktool:regroup/0
data modify storage nktool:array return[0].Slot set value 0b
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify block ~ ~ ~ Items[{Slot:0b}] set from storage nktool:array return[0]
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run item replace entity @a[tag=nktemp] player.cursor from block ~ ~ ~ container.0
#重置容器界面
execute as @e[tag=nkworkblock,tag=nktemp] run data modify storage nmo:temp button merge from entity @s data
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run \
    function nkworkblock:button/reload2 with storage nmo:temp button
#后处理
tag @s remove nktemp
tag @e[tag=nkworkblock,tag=nktemp] remove nktemp
scoreboard players reset #arr nkTemp
data remove storage nktool:array return