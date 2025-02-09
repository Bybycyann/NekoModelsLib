$execute as @e[tag=nkworkblock] if data entity @s {data:{player:[$(UUID)]}} at @s align xyz run \
    data modify block ~ ~ ~ Items set from storage nmo:container $(parent).$(page).Items
$execute as @e[tag=nkworkblock] if data entity @s {data:{player:[$(UUID)]}} run data modify entity @s data.page set value $(page)
playsound minecraft:block.lever.click