#物品迁移(可以添加一个计分项用来在main函数中识别Shift+click)
item replace entity @s player.crafting.0 from entity @s container.0
item replace entity @s container.0 from entity @s player.cursor
#通过进度触发器调用button/main
item replace entity @s container.0 from entity @s player.crafting.0
item replace entity @s player.crafting.0 with minecraft:air