#>advancement/open.json
tag @s add nktemp
#声音屏蔽
execute as @a if entity @n[tag=nkworkblock,distance=..15] run stopsound @s block block.barrel.open
#旧绑定剔除
execute as @e[tag=nkworkblock] run function nkworkblock:use/unlik with entity @p[tag=nktemp]
#选中方块
function nktool:raycast/0
#导入player-UUID
function nkworkblock:use/binding with entity @s
    #>binding
    #    $execute at @n[tag=nkraycast] unless data entity @n[tag=nmoe] {data:{player:[$(UUID)]}} run \
    #        data modify entity @n[tag=nmoe] data.player prepend from entity @s UUID
#后处理
kill @n[tag=nkraycast]
tag @s remove nktemp
#重置成就触发器
advancement revoke @s only nkworkblock:use