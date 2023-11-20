extends Process


## stuff for item picker
@export var item: Enum.ITEMS
@export var item_picker_array: Array[Enum.ITEMS]
@onready var item_picker_ui: Control = %ItemPickerUI


func get_accepted_items():
	Globals.get_constuctor_recipe(item)




## for direction_matters group
func get_input_directions_array()-> Array[int]:
	var array: Array[int] = []
	for i in 3:
		if i != direction:
			array.append(i)
	return array
