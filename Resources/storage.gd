extends Resource
class_name Storage
# if any_item is true this should be the only sorage the item has, or change move_item()


@export var any_item: bool = true
@export var item: Enum.ITEMS
@export var storage_limit: int = 5

var item_storage: Array[int] = []
var storage_space: int = 0


func has_reached_storage_limit()-> bool:
	if storage_space >= storage_limit:
		#print(storage_space, storage_limit, "check from storage")
		return false
	return true


func has_storage()-> bool:
	if item_storage == []:
		return false
	return true
