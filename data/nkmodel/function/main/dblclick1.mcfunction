#单/双击判定1
    #防tick重复判定
    tag @n[type=minecraft:marker,tag=nmoe] add nktemp
    tag @s add nktemp
    #预处理
    data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.attack set from entity @s attack
    data modify entity @n[type=minecraft:marker,tag=nmoe,tag=nktemp] data.interaction set from entity @s interaction
    data remove entity @s attack
    data remove entity @s interaction
    schedule function nkmodel:main/dblclick2 3 append