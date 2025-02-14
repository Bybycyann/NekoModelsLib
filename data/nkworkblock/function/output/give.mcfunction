execute at @s run summon minecraft:item ~ ~ ~ {Item:{id:paper},Age:5998.9s,Tags:["nkoutput"],PickupDelay:0}
scoreboard players remove #give nkTemp 1
execute as @e[tag=nkoutput] run data modify entity @s Item.id set from storage nmo:temp recipe.id
execute as @e[tag=nkoutput] run data modify entity @s Item.components set from storage nmo:temp recipe.components
execute as @e[tag=nkoutput] if score #give nkTemp matches 0 run return fail
function nkworkblock:output/give