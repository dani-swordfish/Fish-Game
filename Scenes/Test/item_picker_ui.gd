extends Control

var item_picker: Control

@onready var grid_container: GridContainer = %GridContainer

const ITEM_BOX_FOR_PICKER = preload("res://Scenes/UI/item_box_for_picker.tscn")
@onready var mouse_click: AudioStreamPlayer = $"../../Sounds/MouseClick"

func _ready() -> void:
	close()


func open(item_array:Array[int], current_item_picker: Control):
	item_picker = current_item_picker
	
	if item_array.size() == 0:
		printerr("no options for options picker")
	
	for item in item_array:
		spawn_item_box(item)
		mouse_click.play()
	show()

func spawn_item_box(item: int):
	var item_box_inst: Panel = ITEM_BOX_FOR_PICKER.instantiate()
	item_box_inst.item = item
	grid_container.add_child(item_box_inst)
	
	

func on_choice(item):
	for child in grid_container.get_children():
		child.queue_free()
	item_picker.update_item(item)
	mouse_click.play()
	close()

func close():
	hide()



