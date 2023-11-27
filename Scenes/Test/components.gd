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


func _on_sub_machine_before_components_changed() -> void:
	for nodes in get_tree().get_nodes_in_group("basic_conveyor"):
		nodes.before_components_changed()
	

func _on_sub_machine_components_changed() -> void:
	#print("_on_sub_machine_components_changed()")
	for child in get_children():
		child._components_changed()
	

func _on_sub_machine_after_components_changed() -> void:
	for nodes in get_tree().get_nodes_in_group("basic_conveyor"):
		nodes.after_components_changed()



