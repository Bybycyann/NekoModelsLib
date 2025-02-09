#为目标容器添加玩家UUID
$execute at @n[tag=nkraycast] unless data entity @n[tag=nkworkblock] {data:{player:[$(UUID)]}} run \
    data modify entity @n[tag=nkworkblock] data.player append from entity @s UUID