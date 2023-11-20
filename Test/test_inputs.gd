extends Control


func _ready() -> void:
	
	if true:
		print("after if ready")
		accept_event()
		return
	else:
		print("after else ready")
		
		


# triggers once on pressed and once on released!!!!!!!
func _unhandled_key_input(event: InputEvent):
#	if event.is_action_pressed("ui_cancel"):
#		print("pressed")
#		return
#	if event.is_action_released("ui_cancel"):
#		print("released")
#	if event.pressed:
#		print("test")
	pass


# triggers once on pressed and once on released!!!!!!!
func _input(event: InputEvent) -> void:
#	print("event")
	pass
	
	if event.is_action_pressed("ui_cancel"):
		print("pressed")
		return
	if event.is_action_released("ui_cancel"):
		print("released")
	if event is InputEventKey and event.pressed:
		print("test")
	
#	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
#		print("after if")
#		accept_event()
#		return
#	else:
#		print("after else")
