data modify storage nmo:index cask set value {\
    template:"default",\
    item:{\
        id:"minecraft:barrier",\
        components:{\
            "minecraft:custom_model_data":7810001,\
            "minecraft:item_data":{\
                translate:"item.nkfurniture.cask"\
            }\
        }\
    },\
    event:{\
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