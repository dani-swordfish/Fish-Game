extends Control

var item_picker: Control

@onready var grid_container: GridContainer = $GridContainer

const ITEM_BOX: PackedScene = preload("res://Scenes/UI/Item Boxes/item_box.tscn")

func _ready() -> void:
	close()


func open(item_array:Array[int], current_item_picker: Control):
	item_picker = current_item_picker
	
	for item in item_array:
		spawn_item_box(item)
	show()

func spawn_item_box(item: int):
	var item_box_inst: Panel = ITEM_BOX.instantiate()
	item_box_inst.item = item
	grid_container.add_child(item_box_inst)
	
	

func on_choice(item):
	for child in grid_container.get_children():
		child.queue_free()
	item_picker.update_item(item)
	close()

func close():
	hide()



