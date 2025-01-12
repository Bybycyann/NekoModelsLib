#单/双击判定1
    data modify entity @n[type=minecraft:marker,tag=nmoe] Tags set value ["nmoee"]
    data modify entity @s Tags set value ["nmoe"]

    data remove entity @s attack
    data remove entity @s interaction
    schedule function nkmodel:main/dblclick2 3.5 append