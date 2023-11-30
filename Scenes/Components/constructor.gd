extends Process
# TODO simple pocessor, use inherrited scene or bool to idintify or group

## stuff for item picker
@export var item: Enum.ITEMS
@export var item_picker_array: Array[Enum.ITEMS]
@export var player_can_pick: bool = true
@export var override_level_default: bool = false
@onready var item_picker_ui: Control = Globals.references.item_picker_ui


func is_item_in_recipe(item_node_received) -> bool:
	for item_and_amount in Globals.get_constuctor_recipe(item):
		if item_and_amount[0] == item_node_received.item:
			return true
	return false

# could move to process
func get_storage(item_node_received)-> Storage:
	for storage in storage_array:
		if storage.item == item_node_received.item:
			return storage
	printerr("no storage found for this item, should not happen")
	return null


func get_has_space(item_node_received)-> bool:
	#print(item_node_received.item, Globals.get_constuctor_recipe(item), " constructor")
	
	if !is_item_in_recipe(item_node_received):
		return false
	
	var storage: Storage = get_storage(item_node_received)
	if storage.has_reached_storage_limit():
		#print("test has reached limit", storage, storage.item)
		return false
	return true


func _ready() -> void:
	super._ready()


func _physics_process(delta: float) -> void:
	if next_component == null: return
	
	if has_item_ready:
		if next_component.get_has_space(new_item_node_array[0]):
			move_item(direction, next_component, new_item_node_array[0])


func after_item_moved():
	process_timer.start()
	

func item_arrived(arrived_item_node):
	if !is_item_in_recipe(arrived_item_node):
		printerr("invalid item arrived in constuctor should never happen,", \
		"will give inacurate sorage numbers")
		arrived_item_node.queue_free()
		return
	
	var new_item = arrived_item_node.item
	arrived_item_node.queue_free()
	
	for i in storage_array.size():
		if new_item == storage_array[i].item:
			storage_array[i].item_storage.append(new_item)
	
	if !has_item_ready and process_timer.time_left == 0:
		process_timer.start()
	

func construct_item():
	new_item_node_array = []
	
	new_item_node_array.append(spawn_item(item))
	
	for i in storage_array.size():
		storage_array[i].storage_space -= storage_array[i].items_needed
		for j in storage_array[i].items_needed:
			storage_array[i].item_storage.pop_back()
	has_item_ready = true
	

func _on_process_timer_timeout() -> void:
	if has_storage_check() and !has_item_ready:
		construct_item()
		process_timer.start()


func get_accepted_items():
	Globals.get_constuctor_recipe(item)


#func item_updated():
	#reset_storage()


func reset_storage():
	storage_array = []
	
	if Globals.get_constuctor_recipe(item) == []:
		printerr("item selcted by constructor has no recipe")
		return
	
	for ingredient: Array[int] in Globals.get_constuctor_recipe(item):
		var new_storage: Storage = Storage.new()
		# could change storage limit for certain items
		storage_array.append(new_storage)
		new_storage.item = ingredient[0]
		new_storage.any_item = false
		if ingredient[1] > 1:
			new_storage.storage_limit *= ingredient[1]
			new_storage.items_needed = ingredient[1]


## for direction_matters group
func get_input_directions_array()-> Array[int]:
	var opposite_direction = Globals.get_opposite_direction(direction)
	var array: Array[int] = []
	for i in range(4):
		if i != opposite_direction:
			array.append(i)
	return array


