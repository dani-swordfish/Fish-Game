extends Control


@onready var menu_button: Button = $MenuButton



func _ready() -> void:
	menu_button.hide()
	$AudioStreamPlayer.play()
	await get_tree().create_timer(3).timeout
	menu_button.show()
	


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu/Main Menu/main_menu.tscn")



