extends Control


@onready var item_sprite: Sprite2D = $"../ItemSprite"


func _ready() -> void:
	update_item(get_parent().item)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.is_pressed() \
	and event.button_index == MOUSE_BUTTON_LEFT:
		get_parent().item_picker_ui.open(get_parent().item_picker_array, self)
		print("clicked")

func update_item(item):
	get_parent().item = item
	item_sprite.frame_coords = Globals.get_item_frame_coords(item)
	
