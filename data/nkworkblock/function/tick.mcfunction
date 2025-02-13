#marker & item_display 非 barrel 自检
execute as @e[tag=nkworkblock] at @s if entity @a[distance=..20] unless block ~ ~ ~ minecraft:barrel run \
    function nkworkblock:basic/break with entity @s data
#闭合容器自检
execute as @e[tag=nkworkblock] at @s if entity @a[distance=..20] align xyz if data entity @s data.player if predicate nkworkblock:close run function nkworkblock:basic/close with entity @s data
#butto & 占位符单击交互监听
execute as @a if items entity @s player.cursor *[custom_data~{tag:nkgui}] at @s run function nkworkblock:button/click
execute as @a if items entity @s weapon.offhand *[custom_data~{tag:nkgui}] at @s run function nkworkblock:button/f
#输出交互监听
execute as @a if items entity @s player.cursor *[custom_data~{tag:output}] at @s run function nkworkblock:output/click with entity @s
#execute as @a if items entity @s weapon.offhand *[custom_data~{tag:output}] at @s run function nkworkblock:output/f
#home页配方监听
execute as @e[tag=nkworkblock] at @s align xyz \
    if predicate nkworkblock:open \
    if data entity @s {Tags:["nkworkblock"],data:{page:"home"}} run \
    function nkworkblock:recipes/0 with entity @s data
#清除gui掉落物
execute as @e[type=item] if data entity @s {Item:{components:{"minecraft:custom_data":{tag:"nkgui"}}}} run kill @s