extends Process
## only _on_play() and phyisics_process() and raycasts are differnt from cutter


func _ready() -> void:
	# TODO set item spacific time delay
	super._ready()
	

func _on_play():
	super._on_play()


func reset_storage():
	#print("cutter storage reset")
	storage_array = []
	var new_storage: Storage = Storage.new()
	storage_array = [new_storage]


func _physics_process(delta: float) -> void:
	if next_component == null: return
	#print(has_item_ready, " cutter has item ready")
	
	if has_item_ready:
		if next_component.get_has_space(new_item_node_array[0]):
			move_item(direction, next_component, new_item_node_array[0])
			new_item_node_array.pop_front()
		
		if new_item_node_array.size() > 0:
			has_item_ready = true
			after_item_moved()
			


func after_item_moved():
	process_timer.start()


# super.item_arrived is never run check if changing super
# has_item_ready is changed in cut item instead
func item_arrived(arrived_item_node):
	## can happen when game is stopped, this is normal
	if item_node == null:
		return
	
	if Globals.get_cutter_recipe(item_node.item) == []:
		print("invalid item distroyed")
		item_node.queue_free()
		storage_array[0].storage_space -= 1
		return
	
	var item = item_node.item
	item_node.queue_free()
	storage_array[0].item_storage.append(item)
	
	if !has_item_ready and process_timer.time_left == 0:
		process_timer.start()
	

func cut_item():
	
	#await get_tree().create_timer(time_delay).timeout
	new_item_node_array = []
	
	var output_array: Array[Array] = Globals.get_cutter_recipe(storage_array[0].item_storage.pop_back())
	
	for item_and_amount: Array[int] in output_array:
		for i in item_and_amount[1]:
			new_item_node_array.append(spawn_item(item_and_amount[0]))
	
	storage_array[0].storage_space -= 1
	has_item_ready = true
	

func _on_process_timer_timeout() -> void:
	if has_storage_check() and !has_item_ready:
		cut_item()
		process_timer.start()


func get_direction(i: int) -> int:
	var object_direction: int
		
	if i == 0:
		object_direction = direction
	elif i == 1:
		object_direction = direction + 1
	elif i == 2:
		object_direction = direction - 1
	
	if object_direction > 3:
		object_direction -= 4
	elif object_direction < 0:
		object_direction += 4
	
	
	return object_direction

## for direction_matters group
func get_input_directions_array()-> Array[int]:
	var array: Array[int] = [direction]
	return array
