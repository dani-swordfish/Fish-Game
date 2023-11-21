extends Process
## will distroy any invalid items like a bin, could change for gameplay resons


var next_component_2: Node2D = null
var next_component_3: Node2D = null

var next_component_array: Array[Node2D] = [
	next_component,
	next_component_2,
	next_component_3,
]

@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2
@onready var ray_cast_2d_3: RayCast2D = $RayCast2D3

func _ready() -> void:
	# TODO set item spacific time delay
	super._ready()
	
	await get_tree().create_timer(0.1).timeout
	next_component_2 = get_next_component(ray_cast_2d_2, get_direction(1))
	next_component_3 = get_next_component(ray_cast_2d_3, get_direction(2))


func _physics_process(delta: float) -> void:
	if next_component == null: return
	#print(has_item_ready, " cutter has item ready")
	
	if has_item_ready:
		if new_item_node_array.size() == 1:
			if next_component.get_has_space(new_item_node_array[0]):
				move_item(direction, next_component, new_item_node_array[0])
				after_item_moved()
		
		if new_item_node_array.size() == 2:
			if next_component_2 == null: return
			if next_component.get_has_space(new_item_node_array[0]) and next_component_2.get_has_space(new_item_node_array[1]):
				move_item(direction, next_component, new_item_node_array[0])
				move_item(get_direction(1), next_component_2, new_item_node_array[1])
				after_item_moved()
		
		if new_item_node_array.size() == 3:
			if next_component_2 == null or next_component_3 == null: return
			if next_component.get_has_space(new_item_node_array[0]) and next_component_2.get_has_space(new_item_node_array[1]) and next_component_3.get_has_space(new_item_node_array[2]):
				move_item(direction, next_component, new_item_node_array[0])
				move_item(get_direction(1), next_component_2, new_item_node_array[1])
				move_item(get_direction(2), next_component_3, new_item_node_array[2])
				after_item_moved()
		

func after_item_moved():
	process_timer.start()


# super.item_arrived is never run check if changing super
# has_item_ready is changed in cut item instead
func item_arrived(arrived_item_node):
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
	
	var output_array: Array[int] = Globals.get_cutter_recipe(storage_array[0].item_storage.pop_back())
	
	for i in output_array.size():
		new_item_node_array.append(spawn_item(output_array[i]))
	
	
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
