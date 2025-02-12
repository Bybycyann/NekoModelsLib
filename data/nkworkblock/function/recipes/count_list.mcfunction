#提取合成栏材料count列表
data modify storage nktool:array input.source append from storage nktool:array input.temp[0].count
data remove storage nktool:array input.temp[0]
execute store result score #arr nkTemp run data get storage nktool:array input.temp
execute if score #arr nkTemp matches 0 run return run data remove storage nktool:array input.temp
function nkworkblock:recipes/count_list