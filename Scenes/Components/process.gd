extends Conveyor
class_name Process

# stores ready items only
# used by processors which spawn item/s
# not current used by spawner
var new_item_node_array: Array[Node2D]

## for takes_multiple_items group
# not being used
#var item_node_array: Array[Node2D]

# Not being used, export in timer being used
var time_delay: float = 2

## storage
@export var storage_array: Array[Storage]

func has_storage_check():
	for i in storage_array.size():
		if !storage_array[i].has_storage():
			return false
	return true



const ITEM_SCENE = preload("res://Scenes/Item/item.tscn")

@onready var items: Node2D = %Items
@onready var process_timer: Timer = $ProcessTimer

func get_has_space(item_node_received)-> bool:
	if is_in_group("stores_items"):
		return storage_array[0].has_reached_storage_limit()
	else:
		return has_space


func spawn_item(item: Enum.ITEMS, item_position = global_position) -> Node2D:
	if item == 0:
		printerr("tried to spawn invalid item")
		return
	
	var item_inst: Node2D = ITEM_SCENE.instantiate()
	item_inst.item = item
	items.add_child(item_inst)
	#items.call_deferred("add_child", item_inst)
	item_inst.global_position = item_position
	
	return item_inst
