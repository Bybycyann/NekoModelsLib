#尽量还原了原版give的效果, 但是tick抓不到瞬间生成的那个掉落物实体(要加上也不是不行,但是感觉没必要,命令有点多余.)
$summon minecraft:item ~ ~ ~ {Item:{id:"minecraft:cow_spawn_egg",count:1,components:{"minecraft:entity_data":{id:"minecraft:marker",Tags:["nmo"],data:{index:$(id)}}}},Age:5998.9s}
$data modify entity @n[type=minecraft:item] Item merge from storage nmo:index $(id).display.item
data modify entity @n[type=item] Owner set from entity test UUID
$tellraw @s [{"text":"已将1个["},{"translate":"item.nkmodel.$(id)","hoverEvent":{"action":"show_item","contents":{"id":"minecraft:cow_spawn_egg","components":{"item_name":"{\"translate\":\"item.nkmodel.$(id)\"}"}}}},{"text":"]给予"},{"selector":"@s"}]

#(这部分是仿照give的生成掉落物实体,用处不大)
$summon minecraft:item ~ ~1.2 ~ {Item:{id:"minecraft:cow_spawn_egg",count:1,components:{"minecraft:entity_data":{id:"minecraft:marker",Tags:["nmo"],data:{index:$(id)}}}},Age:5999s,PickupDelay:32767s}
$data modify entity @n[type=minecraft:item,nbt={PickupDelay:32767s}] Item merge from storage nmo:index $(id).item