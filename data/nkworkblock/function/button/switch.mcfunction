#声音事件
playsound minecraft:block.lever.click
#预处理
tag @s add nktemp
$execute as @e[tag=nkworkblock] if data entity @s {data:{player:[$(UUID)]}} run tag @s add nktemp
#回退非空位交互物品
function nkworkblock:button/back
#切换页面
$execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run data modify block ~ ~ ~ Items set from storage nmo:container $(parent).$(page).Items
$execute as @e[tag=nkworkblock,tag=nktemp] run data modify entity @s data.page set value $(page)
#后处理
tag @s remove nktemp
tag @e[tag=nkworkblock,tag=nktemp] remove nktemp
scoreboard players reset #arr nkTemp
data remove storage nktool:array return