extends Control

@onready var world_states: StateChart = $"../../WorldStates"

@onready var stop_button: Button = $PanelContainer/MarginContainer/HBoxContainer/StopButton




func _on_play_button_pressed() -> void:
	world_states.send_event("play")


func _on_stop_button_pressed() -> void:
	world_states.send_event("stop")
