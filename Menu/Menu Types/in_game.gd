extends MenuType

@onready var panel: Panel = $Panel
@onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	var size_x: float = v_box_container.size.x + 180
	var size_y: float = v_box_container.size.y + 64
	panel.set_custom_minimum_size(Vector2(size_x,size_y))

