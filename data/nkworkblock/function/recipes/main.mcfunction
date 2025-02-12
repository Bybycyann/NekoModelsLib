#产物生成
data modify block ~ ~ ~ Items[{components:{"minecraft:custom_data":{result:null}}}].components set value {"minecraft:custom_data":{tag:"output"}}
data modify block ~ ~ ~ Items[{components:{"minecraft:custom_data":{tag:"output"}}}].id set from storage nktool:array output[0].result.id
data modify block ~ ~ ~ Items[{components:{"minecraft:custom_data":{tag:"output"}}}].count set from storage nktool:array output[0].result.count
data modify block ~ ~ ~ Items[{components:{"minecraft:custom_data":{tag:"output"}}}].components merge from storage nktool:array output[0].result.components