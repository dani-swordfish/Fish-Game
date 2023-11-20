extends RichTextLabel


signal choice_chosen(choice_index: int)


var choice_index: int 

func _on_gui_input(event: InputEvent) -> void:
	if InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			choice_chosen.emit(choice_index)
