extends CanvasLayer



func _ready() -> void:
	show()


#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_copy"):
		#hide()
	#if event.is_action_pressed("ui_cut"):
		#show()



func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
