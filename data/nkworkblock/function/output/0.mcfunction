#读取合成槽
function nkworkblock:recipes/read
#光标选取合成槽预处理
execute if score #click nkTemp matches 1 run scoreboard players set #remove nkTemp 1
#Shift批量合成预处理
execute unless score #click nkTemp matches 1 run function nkworkblock:output/shift_click
#合成槽消耗处理
function nkworkblock:output/main
#后处理
scoreboard players reset #click nkTemp
#重置成就触发器
advancement revoke @s only nkworkblock:output