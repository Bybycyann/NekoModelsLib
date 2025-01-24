#破坏与移动事件
    #break
    $execute as @n[type=minecraft:interaction,tag=nmo] on attacker \
        unless items entity @s weapon.* minecraft:iron_pickaxe[minecraft:custom_model_data=7810001] \
        as @n[type=minecraft:marker,tag=nmoe] run \
        function nkmodel:data/event/group/break with entity @s data.param.$(attr)
    #move
    function nkmodel:data/event/group/move