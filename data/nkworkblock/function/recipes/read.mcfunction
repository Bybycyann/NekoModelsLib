#读取合成槽
data modify storage nktool:array input.source set from block ~ ~ ~ Items
data modify storage nktool:array input.condition set value "nkgui"
scoreboard players set #arr nkTemp 1
scoreboard players set #output nkTemp 0
function nktool:regroup/0
data modify storage nktool:array input.source set from storage nktool:array output
data modify storage nktool:array input.condition set value "output"
scoreboard players set #arr nkTemp 1
scoreboard players set #output nkTemp 0
function nktool:regroup/0