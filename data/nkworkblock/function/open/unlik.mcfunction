#容器解绑
#二次过滤
$execute unless data entity @s {data:{player:[$(UUID)]}} run return fail
#输入数据
data modify storage nktool:array input.source set from entity @s data.player
$data modify storage nktool:array input.condition set value $(UUID)
#regroup-剔除元素分支
scoreboard players set #regroup nkTemp 0
#列表元素剔除
function nktool:regroup/0
data modify entity @s data.player set from storage nktool:array output
#后处理
data remove storage nktool:array output