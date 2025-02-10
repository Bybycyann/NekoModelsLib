#回退副手分支
scoreboard players set #slot nkTemp 1
#物品迁移
item replace entity @s player.crafting.0 from entity @s container.0
item replace entity @s container.0 from entity @s weapon.offhand
    #通过进度触发器调用button/main
#后处理
item replace entity @s container.0 from entity @s player.crafting.0
item replace entity @s player.crafting.0 with minecraft:air