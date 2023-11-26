extends Resource
class_name Storage
# if any_item is true this should be the only sorage the item has, or change move_item()


@export var any_item: bool = true
@export var item: Enum.ITEMS
@export var storage_limit: int = 5

var item_storage: Array[int] = []
var storage_space: int = 0
var items_needed: int = 1

func has_reached_storage_limit()-> bool:
	#print("storage_space", storage_space, "storage_limit", storage_limit)
	if storage_space >= storage_limit:
		return true
	return false


func has_storage()-> bool:
	if item_storage.size() >= items_needed:
		return true
	return false
