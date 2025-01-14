$data modify entity @s data set from storage nmo:index $(index)
summon minecraft:item_display ~ ~ ~ {Tags:["nmo"]}
summon minecraft:interaction ~ ~ ~ {Tags:["nmo"]}
function nkmodel:main/template with entity @s data
data modify entity @n[type=item_display,tag=nmo] item merge from entity @s data.item
execute if data entity @s data.event.place run \
function nkmodel:main/place with entity @s data.event
data modify entity @s data set from entity @s data.event
data modify entity @s Tags set value ["nmoe"]
execute if entity @s[nbt={data:{dbl:true}}] run tag @n[type=interaction,tag=nmo] add dbl