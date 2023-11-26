extends Node2D




func _on_play_state_exited() -> void:
	for child in get_children():
		child.queue_free()
