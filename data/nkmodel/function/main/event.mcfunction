#事件触发
    #lc
    $execute as @s at @s if entity @s[nbt={data:{attr:1}}] run \
        function nkmodel:data/event/$(left_click) with entity @s data.param.lc
    #rc
    $execute as @s at @s if entity @s[nbt={data:{attr:3}}] run \
        function nkmodel:data/event/$(right_click) with entity @s data.param.rc
    #ldc
    $execute as @s at @s if entity @s[nbt={data:{attr:2}}] run \
        function nkmodel:data/event/$(left_dblclick) with entity @s data.param.ldc
    #rdc
    $execute as @s at @s if entity @s[nbt={data:{attr:4}}] run \
        function nkmodel:data/event/$(right_dblclick) with entity @s data.param.rdc
#重置
    data remove entity @n[type=minecraft:interaction,tag=nmo,tag=nktemp] attack
    data remove entity @n[type=minecraft:interaction,tag=nmo,tag=nktemp] interaction
    data remove entity @s data.attr
    tag @n[type=minecraft:interaction,tag=nmo,tag=nktemp] remove nktemp
    tag @s remove nktemp