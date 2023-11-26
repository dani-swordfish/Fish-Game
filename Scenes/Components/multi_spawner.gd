extends Process

@export var item_array: Array[Enum.ITEMS]

# only works if item array is set on export and not changed
var counter: int = 0

var current_item: Enum.ITEMS:
	get: 
		if counter >= item_array.size():
			counter = 0
		counter += 1
		return item_array[counter - 1]


func _on_play():
	super._on_play()
	counter = 0
	process_timer.start()


func _on_process_timer_timeout() -> void:
	if has_space == false: 
		process_timer.start()
		return
	
	if item_array.size() == 0:
		printerr("no items picked for multi_spawner")
		return
	
	item_node = spawn_item(current_item)
	has_item_ready = true
	process_timer.start()
	has_space = false
