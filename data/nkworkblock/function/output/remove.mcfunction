#合成槽物品消耗运算 输出在 output
# <#temp2 ← input.source[0].count>
execute store result score #temp2 nkTemp run data get storage nktool:array input.source[0].count
# <#temp2 ← #temp - #remove>
scoreboard players operation #temp2 nkTemp -= #remove nkTemp
# <input.source[0].count ← #temp2>
execute store result storage nktool:array input.source[0].count int 1 run scoreboard players get #temp2 nkTemp
# air 转换
execute if score #temp2 nkTemp matches 0 run data modify storage nktool:array input.source[0].id set value "minecraft:air"
# <output ←append— input.source[0]>
data modify storage nktool:array output append from storage nktool:array input.source[0]
# <remove input.source[0]>
data remove storage nktool:array input.source[0]
#递归条件判断
execute store result score #arr nkTemp run data get storage nktool:array input.source
execute if score #arr nkTemp matches 0 run return run data remove storage nktool:array input
#递归
function nkworkblock:output/remove