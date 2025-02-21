#读取合成槽物品数据
function nkworkblock:openslot/0 with entity @s data
data modify storage nktool:array input.source set from block ~ ~ ~ Items
data modify storage nktool:array input.condition set value "nkopenslot"
scoreboard players set #arr nkTemp 1
scoreboard players set #output nkTemp 1
function nktool:regroup/0
function nkworkblock:openslot/1 with entity @s data
data modify entity @s data.temp set from storage nktool:array output
#后处理
scoreboard players reset #output nkTemp