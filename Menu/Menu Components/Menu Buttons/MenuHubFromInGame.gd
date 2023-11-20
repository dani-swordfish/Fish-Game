extends Button
# TODO add confirm pop up to warn player about lost progress


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/Menu Hub/menu_hub.tscn")
