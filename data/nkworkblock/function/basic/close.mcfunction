#屏蔽声音
execute as @a if entity @n[tag=nkworkblock,distance=..15] run stopsound @s block block.barrel.close
#容器重置
data remove entity @s data.player
data modify entity @s data.page set value "home"
$data modify block ~ ~ ~ Items append from storage nmo:container $(id).home.Items