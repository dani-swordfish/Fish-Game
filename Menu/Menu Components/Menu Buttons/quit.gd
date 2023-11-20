extends Button


# quit button won't be visiable on web, as it's not needed.
func _ready() -> void:
	if OS.has_feature("web"):
		hide()


func _on_pressed() -> void:
	get_tree().quit()
