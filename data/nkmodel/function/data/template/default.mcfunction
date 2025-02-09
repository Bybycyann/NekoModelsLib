data modify storage nmo:template default set value \
    {\
        transformation:[1f,0f,0f,0f,0f,1f,0f,0.5f,0f,0f,1f,0f,0f,0f,0f,1f],\
        display:{\
            brightness:{block:0,sky:15},\
            item:{},\
        },\
        event:{\
            dbl:false,\
            place:"playsound",\
            left_click:"group/break-move",\
            left_dblclick:"",\
            right_dblclick:"",\
            param:{lc:{},rc:{}}\
        }\
    }