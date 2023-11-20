extends Button

func _ready() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		button_pressed = true
		text = "Windowed"
	else:
		button_pressed = false
		text = "Fullscreen"
	


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		text = "Windowed"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if !toggled_on:
		text = "Fullscreen"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
