#>tick
#屏蔽声音
execute as @a if entity @n[tag=nkworkblock,distance=..15] run stopsound @s block block.barrel.close
#容器重置
data remove entity @s data.player
$execute unless data entity @s {data:{page:"home"}} run data modify block ~ ~ ~ Items set from storage nmo:container $(id).home.Items
execute if data entity @s data.temp run data modify block ~ ~ ~ Items append from entity @s data.temp[]
execute if data entity @s data.temp run function nkworkblock:openslot/1 with entity @s data
execute if data entity @s data.temp run data remove entity @s data.temp
data modify entity @s data.page set value "home"