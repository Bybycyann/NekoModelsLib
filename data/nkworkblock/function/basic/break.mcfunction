#战利品表预处理, tick函数检测触发
#清除marker & item_display
kill @n[type=minecraft:item_display]
kill @s
#清除gui掉落物
execute as @e[type=item] if data entity @s {Item:{components:{"minecraft:custom_data":{tag:"nkgui"}}}} run kill @s
#填充掉落物数据
$execute as @e[type=minecraft:item] if data entity @s {Item:{components:{"minecraft:custom_data":{tag:"nkworkblock"}}}} run \
   data modify entity @s Item set value {id:"minecraft:cow_spawn_egg",count:1,components:{"minecraft:entity_data":{id:"minecraft:marker",Tags:["nmo"],data:{index:$(id)}}}}
$execute as @e[type=minecraft:item] if data entity @s {Item:{components:{"minecraft:entity_data":{data:{index:$(id)}}}}} run \
    data modify entity @s Item merge from storage nmo:index $(id).display.item