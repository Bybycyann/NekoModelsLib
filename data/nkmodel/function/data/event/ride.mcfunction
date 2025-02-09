#骑乘事件
$summon item_display ~ ~$(ride_height) ~ {Tags:["nmoride"]}
execute as @e[tag=nmoride,tag=!occupy] at @s \
    if entity @n[tag=nmoride,tag=occupy,distance=..0.001] run kill @s
execute as @n[type=minecraft:interaction,tag=nmo] on target run \
    ride @s mount @n[type=item_display,tag=nmoride,tag=!occupy]
tag @n[tag=nmoride,tag=!occupy] add occupy