extends ItemBox


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.is_pressed() \
	and event.button_index == MOUSE_BUTTON_LEFT:
		get_parent().get_parent().get_parent().get_parent().on_choice(item)
