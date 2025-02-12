#删除recipe列表中的count项
data remove storage nktool:array input.source[0].count
data modify storage nktool:array output append from storage nktool:array input.source[0]
data remove storage nktool:array input.source[0]
execute store result score #arr nkTemp run data get storage nktool:array input.source
execute if score #arr nkTemp matches 0 run return run data remove storage nktool:array input
function nkworkblock:recipes/remove_count