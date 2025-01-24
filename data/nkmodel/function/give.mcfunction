$summon minecraft:item ~ ~ ~ {Item:{id:"minecraft:cow_spawn_egg",count:1,components:{"minecraft:entity_data":{id:"minecraft:marker",Tags:["nmo"],data:{index:$(id)}}}},Age:5998.9s}
$data modify entity @n[type=minecraft:item] Item merge from storage nmo:index $(id).item
data modify entity @n[type=item] Owner set from entity test UUID
$tellraw @s [{"text":"已将1个["},{"translate":"item.nkmodel.$(id)","hoverEvent":{"action":"show_item","contents":{"id":"minecraft:cow_spawn_egg","components":{"item_name":"{\"translate\":\"item.nkmodel.$(id)\"}"}}}},{"text":"]给予"},{"selector":"@s"}]
give @s minecraft:iron_pickaxe[max_damage=1200,minecraft:custom_model_data=7810001,minecraft:item_name='{"translate":"item.nkmodel.spanner"}']
$summon minecraft:item ~ ~1.2 ~ {Item:{id:"minecraft:cow_spawn_egg",count:1,components:{"minecraft:entity_data":{id:"minecraft:marker",Tags:["nmo"],data:{index:$(id)}}}},Age:5999s,PickupDelay:32767s}
$data modify entity @n[type=minecraft:item,nbt={PickupDelay:32767s}] Item merge from storage nmo:index $(id).item