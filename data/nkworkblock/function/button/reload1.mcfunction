$execute as @e[tag=nkworkblock] if data entity @s {data:{player:[$(UUID)]}} run data modify storage nmo:temp button merge from entity @s data
$execute as @e[tag=nkworkblock] if data entity @s {data:{player:[$(UUID)]}} at @s align xyz run \
    function nkworkblock:button/reload2 with storage nmo:temp button