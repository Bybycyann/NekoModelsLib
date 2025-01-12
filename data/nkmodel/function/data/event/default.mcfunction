#破坏事件
    #生成掉落物
    #block.wood.break
    #破坏粒子 & 音效
    $particle block{block_state:"$(particle)"} ~ ~0.5 ~ 0.34 0.34 0.34 0 40 normal
    $playsound $(sound) block @a ~ ~0.5 ~
    #删除模型实体
    kill @n[type=minecraft:item_display,tag=nmo]
    kill @n[type=minecraft:interaction,tag=nmo]
    kill @s