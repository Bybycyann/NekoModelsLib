data modify storage nmo:index cask set value {\
    id:cask,\
    template:"default",\
    display:{\
        item:{\
            id:"minecraft:cow_spawn_egg",\
            components:{\
                "minecraft:custom_model_data":7810001,\
                "minecraft:item_name":'{"translate":"item.nkmodel.cask"}'\
            }\
        }\
    },\
    event:{\
        right_click:"group/rotate",\
        param:{\
            place:{sound:"minecraft:block.wood.place"},\
            lc:{\
                attr:"lc",\
                particle:"minecraft:spruce_planks",\
                sound:"minecraft:block.wood.break"\
                }\
        }\
    }\
}