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

#count清除
data modify storage nktool:array input.source set from storage nktool:array output
data remove storage nktool:array output
function nkworkblock:recipes/remove_count

#配方匹配
$data modify storage nktool:array input.source set from storage nmo:recipes $(id)
data modify storage nktool:array input.condition set from storage nktool:array output
data modify storage nktool:array output set from storage nktool:array input.source
function nkworkblock:recipes/regroup
#调用main函数
execute store result score #output nkTemp run data get storage nktool:array output
execute unless score #output nkTemp matches 0 if data block ~ ~ ~ Items[{components:{"minecraft:custom_data":{result:null}}}] run function nkworkblock:recipes/main
execute if score #output nkTemp matches 0 if data block ~ ~ ~ Items[{components:{"minecraft:custom_data":{tag:"output"}}}] run function nkworkblock:recipes/output_reload
#后处理
#data remove storage nktool:array output
scoreboard players reset #arr nkTemp
scoreboard players reset #output nkTemp