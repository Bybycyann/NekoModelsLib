$data modify entity @n[type=minecraft:item_display] transformation set from storage nmo:template $(template).transformation
$data modify entity @n[type=minecraft:item_display] {} merge from storage nmo:template $(template).display
$data modify entity @s data.event merge from storage nmo:template $(template).event