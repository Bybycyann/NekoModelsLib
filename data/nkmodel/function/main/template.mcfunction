$data modify entity @n[type=minecraft:item_display] item merge from storage nmo:template $(template).item
$data modify entity @n[type=minecraft:item_display] transformation set from storage nmo:template $(template).size
$data modify entity @s data.event merge from storage nmo:template $(template).event