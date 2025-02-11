#专为配方匹配特殊处理的regroup函数, 返回值为 output[0]
#将 source[0] 与 condition 进行比对, 若不匹配则返回 1 给 #output
execute store success score #output nkTemp run data modify storage nktool:array input.source[0].recipe set from storage nktool:array input.condition
execute if score #output nkTemp matches 0 run return run data remove storage nktool:array input
#剔除 source[0]
data remove storage nktool:array input.source[0]
#剔除 output[0]
data remove storage nktool:array output[0]
#递归条件判断
execute store result score #arr nkTemp run data get storage nktool:array input.source
execute if score #arr nkTemp matches 0 run return run data remove storage nktool:array input
function nkworkblock:recipes/regroup