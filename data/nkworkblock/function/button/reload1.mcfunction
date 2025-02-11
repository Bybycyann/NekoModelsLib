#预处理
tag @s add nktemp
$execute as @e[tag=nkworkblock] if data entity @s {data:{player:[$(UUID)]}} run tag @s add nktemp
#遍历容器并回退物品
function nkworkblock:button/back
#重置容器界面
execute as @e[tag=nkworkblock,tag=nktemp] run data modify storage nmo:temp button merge from entity @s data
execute as @e[tag=nkworkblock,tag=nktemp] at @s align xyz run \
    function nkworkblock:button/reload2 with storage nmo:temp button
#后处理
tag @s remove nktemp
tag @e[tag=nkworkblock,tag=nktemp] remove nktemp
scoreboard players reset #arr nkTemp
data remove storage nktool:array output