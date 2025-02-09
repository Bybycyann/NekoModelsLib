#>nkmodel/0
#承接自定义模型主函数
#放置音效
playsound block.wood.place block @a
#容器数据填充
fill ~ ~ ~ ~ ~ ~ minecraft:barrel
$data modify block ~ ~ ~ {} merge from storage nmo:container $(id).home
data modify entity @s data.page set value "home"
data modify entity @s Tags set value ["nkworkblock"]