extends Control

@onready var level_info_button: Button = $"../ComponentPicker/LevelInfoButton"


func _ready() -> void:
	open()


func open():
	show()


func close():
	hide()

func _on_level_info_button_pressed() -> void:
	open()


func _on_continue_button_pressed() -> void:
	close()


func _on_play_state_entered() -> void:
	level_info_button.disabled = true


func _on_play_state_exited() -> void:
	level_info_button.disabled = false
