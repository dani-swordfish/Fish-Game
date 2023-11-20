extends Conveyor
class_name Process


# Not being used, export in timer being used
var time_delay: float = 2

## storage
var item_storage: Array[int] = []
var storage_limit: int = 5

## number of items either in storage or qued for storage
var storage_space: int


const ITEM_SCENE = preload("res://Scenes/Item/item.tscn")

@onready var items: Node2D = %Items
@onready var process_timer: Timer = $ProcessTimer

func get_has_space()-> bool:
	return has_reached_storage_limit()

## storage
func has_reached_storage_limit()-> bool:
	if storage_space >= storage_limit:
		return false
	return true


func has_storage()-> bool:
	if item_storage == []:
		return false
	return true


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
