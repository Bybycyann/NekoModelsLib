#>advancement/button.json|button/f.mcf
#补全容器界面
data modify storage nmo:temp button.UUID set from entity @s UUID
data modify storage nmo:temp button merge from entity @s Inventory.[{components:{"minecraft:custom_data":{tag:"nkgui"}}}].components."minecraft:custom_data"
execute store success score #button nkTemp run function nkworkblock:button/switch with storage nmo:temp button
#非事件性占位符交互处理
execute if score #button nkTemp matches 0 run function nkworkblock:button/reload1 with storage nmo:temp button
#后处理
scoreboard players reset #button nkTemp
data remove storage nmo:temp button
clear @s minecraft:paper[minecraft:custom_data~{tag:"nkgui"}]
#重置进度触发器
advancement revoke @s only nkworkblock:button