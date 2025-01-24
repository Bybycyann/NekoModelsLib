#掉落物事件
$summon minecraft:item ~ ~0.5 ~ {Item:{id:"minecraft:cow_spawn_egg",count:1,components:{"minecraft:entity_data":{id:"minecraft:marker",Tags:["nmo"],data:{index:$(id)}}}},PickupDelay:8,Motion:[0.0d,0.2d,0.0d]}
$data modify entity @n[type=minecraft:item,nbt={Age:0s}] Item merge from storage nmo:index $(id).item