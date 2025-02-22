#marker & item_display 非 barrel 自检
execute as @e[type=minecraft:marker,tag=nkworkblock] at @s if entity @a[distance=..20] unless block ~ ~ ~ minecraft:barrel run \
    function nkworkblock:basic/break with entity @s data
#闭合容器自检
execute as @e[type=minecraft:marker,tag=nkworkblock] at @s if entity @a[distance=..20] align xyz if data entity @s data.player if predicate nkworkblock:close run function nkworkblock:basic/close with entity @s data
#butto & 占位符单击交互监听
execute as @a if items entity @s player.cursor *[custom_data~{tag:nkgui}] at @s run function nkworkblock:button/click
execute as @e[type=item] if data entity @s {Item:{components:{"minecraft:custom_data":{tag:"nkgui"}}}} on origin run function nkworkblock:button/drop with entity @s
#输出交互监听
execute as @a if items entity @s player.cursor *[custom_data~{tag:output}] at @s run function nkworkblock:output/click with entity @s
execute as @e[type=item] if data entity @s {Item:{components:{"minecraft:custom_data":{tag:"output"}}}} run function nkworkblock:output/drop
#home页配方监听
execute as @e[type=minecraft:marker,tag=nkworkblock] at @s align xyz \
    if predicate nkworkblock:open \
    if data entity @s {Tags:["nkworkblock"],data:{page:"home"}} run \
    function nkworkblock:recipes/0 with entity @s data
#防漏斗矿车
execute as @e[type=minecraft:hopper_minecart,tag=!nklock] at @s if entity @n[type=minecraft:marker,tag=nkworkblock,distance=..2] run tag @s add nklock
execute as @e[type=minecraft:hopper_minecart,tag=nklock] if data entity @s {Enabled:1b} run data modify entity @s[type=minecraft:hopper_minecart] Enabled set value 0b
execute as @e[type=minecraft:hopper_minecart,tag=nklock] at @s unless entity @n[type=minecraft:marker,tag=nkworkblock,distance=..2] run data modify entity @s[type=minecraft:hopper_minecart] Enabled set value 1b
execute as @e[type=minecraft:hopper_minecart,tag=nklock] at @s unless entity @n[type=minecraft:marker,tag=nkworkblock,distance=..2] run tag @s remove nklock
#防漏斗
execute as @e[type=minecraft:marker,tag=nkworkblock] at @s align xyz positioned ~ ~-1 ~ if predicate nkworkblock:hopper_state run fill ~ ~ ~ ~ ~ ~ minecraft:hopper[enabled=false]
#清除gui掉落物
execute as @e[type=item] if data entity @s {Item:{components:{"minecraft:custom_data":{tag:"nkgui"}}}} run kill @s