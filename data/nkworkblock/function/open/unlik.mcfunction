#容器解绑
    #二次过滤
    $execute unless data entity @s {data:{player:[$(UUID)]}} run return fail
    #输入数据
    data modify storage nktool:array input.source set from entity @s data.player
    $data modify storage nktool:array input.remove set value $(UUID)
    #列表元素剔除
    function nktool:regroup/0
    data modify entity @s data.player set from storage nktool:array return
    data remove storage nktool:array return