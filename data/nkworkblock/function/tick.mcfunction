#marker & item_display 非 air 自检
execute as @e[tag=nkworkblock] at @s if entity @a[distance=..20] unless block ~ ~ ~ minecraft:barrel run \
    function nkworkblock:basic/break with entity @s data
#闭合容器自检
execute as @e[tag=nkworkblock] at @s align xyz if data entity @s data.player if predicate nkworkblock:close run function nkworkblock:basic/close with entity @s data

#button 点击检测
execute as @a if items entity @s player.cursor minecraft:paper[custom_data~{tag:nkgui}] at @s run function nkworkblock:button/click

#清除gui掉落物
execute as @e[type=item] if data entity @s {Item:{components:{"minecraft:custom_data":{tag:"nkgui"}}}} run kill @s