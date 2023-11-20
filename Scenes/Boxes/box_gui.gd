extends Box


# TODO also on number hotkey
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print("test")
		if event.button_index == MOUSE_BUTTON_LEFT:
			player_hand.pick_up_componant(component)
