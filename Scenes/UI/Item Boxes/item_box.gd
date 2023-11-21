extends Panel

var item: Enum.ITEMS

@onready var sprite: Sprite2D = $Sprite


func _ready() -> void:
	set_sprite()

func set_sprite():
	sprite.frame_coords = Globals.get_item_frame_coords(item)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.is_pressed() \
	and event.button_index == MOUSE_BUTTON_LEFT:
		get_parent().get_parent().on_choice(item)
