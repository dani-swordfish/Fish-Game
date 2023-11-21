extends Process


## stuff for item picker
@export var item: Enum.ITEMS
@export var item_picker_array: Array[Enum.ITEMS]
@onready var item_picker_ui: Control = %ItemPickerUI



func get_has_space(item_node_received)-> bool:
	#print(item_node_received.item, Globals.get_constuctor_recipe(item), " constructor")
	if !item_node_received.item in Globals.get_constuctor_recipe(item):
		print("item type reject")
		return false
	
	var store: int = Globals.get_constuctor_recipe(item).find(item_node_received.item)
	if !storage_array[store].has_reached_storage_limit():
		#print("reached limit", storage_array[store], store, storage_array[store].storage_space, storage_array[store].storage_limit)
		return false
	return true


func _ready() -> void:
	super._ready()

# TODO at player start of game
func _physics_process(delta: float) -> void:
	if next_component == null: return
	
	if has_item_ready:
		print("test", new_item_node_array[0])
		if next_component.get_has_space(new_item_node_array[0]):
			move_item(direction, next_component, new_item_node_array[0])


func after_item_moved():
	process_timer.start()
	

func item_arrived(arrived_item_node):
	if !arrived_item_node.item in Globals.get_constuctor_recipe(item):
		printerr("invalid item arrived in constuctor should never happen,", \
		"will give inacurate sorage numbers")
		item_node.queue_free()
		return
	
	var new_item = arrived_item_node.item
	arrived_item_node.queue_free()
	
	for i in storage_array.size():
		print(storage_array[i].item, "  item set for stroage array")
		if new_item == storage_array[i].item:
			print("append")
			storage_array[i].item_storage.append(new_item)
	
	if !has_item_ready and process_timer.time_left == 0:
		process_timer.start()
	

func construct_item():
	new_item_node_array = []
	
	new_item_node_array.append(spawn_item(item))
	
	for i in storage_array.size():
		storage_array[i].storage_space -= 1
		storage_array[i].item_storage.pop_back()
	has_item_ready = true
	

func _on_process_timer_timeout() -> void:
	print("timeout  ", has_storage_check() , storage_array)
	if has_storage_check() and !has_item_ready:
		construct_item()
		process_timer.start()


func get_accepted_items():
	Globals.get_constuctor_recipe(item)


func item_updated():
	storage_array = []
	
	if Globals.get_constuctor_recipe(item) == []:
		printerr("item selcted by constructor has no recipe")
		return
	
	for ingredient in Globals.get_constuctor_recipe(item):
		var new_storage: Storage = Storage.new()
		# could change storage limit for certain items
		storage_array.append(new_storage)
		new_storage.item = ingredient
		new_storage.any_item = false
	#print(storage_array)


## for direction_matters group
func get_input_directions_array()-> Array[int]:
	var opposite_direction = Globals.get_opposite_direction(direction)
	var array: Array[int] = []
	for i in range(4):
		if i != opposite_direction:
			array.append(i)
	return array


