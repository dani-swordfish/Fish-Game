extends Button


signal pressed_level(level_number:int)


# starts at 1
var level_number: int



func _on_pressed() -> void:
	pressed_level.emit(level_number)
