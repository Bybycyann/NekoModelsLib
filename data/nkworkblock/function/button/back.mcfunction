execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify storage nktool:array input.source set from block ~ ~ ~ Items
data modify storage nktool:array input.remove set value "nkgui"
scoreboard players set #arr nkTemp 1
function nktool:regroup/0
data modify storage nktool:array return[0].Slot set value 0b
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify block ~ ~ ~ Items[{Slot:0b}] set from storage nktool:array return[0]
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run item replace entity @a[tag=nktemp] player.cursor from block ~ ~ ~ container.0