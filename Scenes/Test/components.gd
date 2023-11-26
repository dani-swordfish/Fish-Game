extends Node2D


func _on_play_state_entered() -> void:
	for child in get_children():
		child._on_play()
	for node in get_tree().get_nodes_in_group("conveyor_animation"):
		node.play()


func _on_play_state_exited() -> void:
	for child in get_children():
		child._on_stop()
	for node in get_tree().get_nodes_in_group("conveyor_animation"):
		node.stop()
