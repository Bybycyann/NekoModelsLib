#掉落物
execute as @n[type=minecraft:interaction,tag=nmo] on attacker \
    unless entity @s[nbt={playerGameType:1}] \
    as @n[type=minecraft:marker,tag=nmoe] at @s run \
    function nkmodel:data/event/drop with entity @s data
#破碎声音
$function nkmodel:data/event/playsound with entity @s data.param.$(attr)
#破碎粒子
$function nkmodel:data/event/block_particle with entity @s data.param.$(attr)
#删除实体
function nkmodel:data/event/kill with entity @s data