#骑乘与旋转事件
    #ride
    $execute as @n[type=minecraft:interaction,tag=nmo] on target \
        unless items entity @s weapon.* minecraft:iron_pickaxe[minecraft:custom_model_data=7810001] \
        as @n[type=minecraft:marker,tag=nmoe] run \
        function nkmodel:data/event/ride with entity @s data.param.$(attr)
    #rotate
    function nkmodel:data/event/group/rotate