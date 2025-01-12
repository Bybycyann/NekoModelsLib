#单/双击判定1
    #防tick重复判定
    data modify entity @n[type=minecraft:marker,tag=nmoe] Tags set value ["nmoee"]
    data modify entity @s Tags set value ["nmoe"]
    #预处理
    data remove entity @s attack
    data remove entity @s interaction
    schedule function nkmodel:main/dblclick2 3.5 append