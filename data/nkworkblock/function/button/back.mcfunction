#openslot-tag
execute as @e[tag=nkworkblock,tag=nktemp] if data entity @s {data:{page:"home"}} at @s align xyz run function nkworkblock:openslot/0 with entity @s data
#input
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify storage nktool:array input.source set from block ~ ~ ~ Items
data modify storage nktool:array input.condition set value "nkgui"
#regroup-container函数分支
scoreboard players set #arr nkTemp 1
#regroup-剔除元素分支
scoreboard players set #output nkTemp 0
function nktool:regroup/0
#regroup-container函数分支
scoreboard players set #arr nkTemp 1
#二次筛除
data modify storage nktool:array input.source set from storage nktool:array output
data modify storage nktool:array input.condition set value "nkopenslot"
function nktool:regroup/0
#regroup-container函数分支
scoreboard players set #arr nkTemp 1
#三次筛除
data modify storage nktool:array input.source set from storage nktool:array output
data modify storage nktool:array input.condition set value "output"
function nktool:regroup/0
#输出列表处理
data modify storage nktool:array output[0].Slot set value 0b
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify block ~ ~ ~ Items[{Slot:0b}] set from storage nktool:array output[0]
#将物品回退(0: 光标槽 1:副手槽)
execute if score #slot nkTemp matches 0 as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run item replace entity @a[tag=nktemp] player.cursor from block ~ ~ ~ container.0
execute if score #slot nkTemp matches 1 as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run item replace entity @a[tag=nktemp] weapon.offhand from block ~ ~ ~ container.0
#后处理
scoreboard players reset #slot nkTemp
scoreboard players reset #output nkTemp
execute as @e[tag=nkworkblock,tag=nktemp] if data entity @s {data:{page:"home"}} at @s align xyz run function nkworkblock:openslot/1 with entity @s data