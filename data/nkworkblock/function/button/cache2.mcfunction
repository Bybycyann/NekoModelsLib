data modify block ~ ~ ~ Items append from entity @s data.temp[]
function nkworkblock:openslot/1 with entity @s data
data remove entity @s data.temp