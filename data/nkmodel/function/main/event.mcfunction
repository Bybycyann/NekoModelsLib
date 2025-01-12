    #lc
    $execute as @s at @s if entity @s[nbt={data:{attr:1}}] run \
        function nkmodel:data/event/$(left_click)

    #rc
    $execute as @s at @s if entity @s[nbt={data:{attr:3}}] run \
        function nkmodel:data/event/$(right_click)

    #ldc
    $execute as @s at @s if entity @s[nbt={data:{attr:2}}] run \
        function nkmodel:data/event/$(left_dblclick)

    #rdc
    $execute as @s at @s if entity @s[nbt={data:{attr:4}}] run \
        function nkmodel:data/event/$(right_dblclick)

    #重置
    data remove entity @n[type=minecraft:interaction,tag=nmoe] attack
    data remove entity @n[type=minecraft:interaction,tag=nmoe] interaction
    data remove entity @s data.attr
    data modify entity @n[type=minecraft:interaction,tag=nmoe] Tags set value ["nmo"]
    data modify entity @s Tags set value ["nmoe"]