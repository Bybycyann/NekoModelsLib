#主执行函数
#>tick
#   execute as @n[type=minecraft:marker,tag=nmo] at @s run \
        function nkmodel:main/0 with entity @s data

	#补全Marker实体数据标签
	$data modify entity @s data set from storage nmo:index $(index)

	#生成模型
	summon minecraft:item_display ~ ~ ~ {Tags:["nmo"]}
	summon minecraft:interaction ~ ~ ~ {Tags:["nmo"]}

	#填充模板数据
	function nkmodel:main/template with entity @s data
    	#>template
    	#   $data modify entity @n[type=minecraft:item_display] item merge from \
    		storage nmo:template $(template).item
    	#   $data modify entity @n[type=minecraft:item_display] transformation set from \
    		storage nmo:template $(template).size
		#	$data modify entity @s data.event set from storage nmo:template $(template).event

	#填充自定义模型数据
	data modify entity @n[type=item_display,tag=nmo] item merge from entity @s data.item

	#放置事件
	execute if data entity @s data.event.place run \
		function nkmodel:main/place with entity @s data.event
		#>place
		#	$function nkmodel:data/event/$(place)

	#模型交互事件由tick.mcfunction下的部分指令组执行

	#清空Marker的template和item数据
	data modify entity @s data set from entity @s data.event
	data modify entity @s Tags set value ["nmoe"]