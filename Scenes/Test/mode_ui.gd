extends Control

@onready var world_states: StateChart = $"../../WorldStates"

@onready var stop_button: Button = $PlayStop/MarginContainer/HBoxContainer/StopButton

@onready var play: AudioStreamPlayer = $"../../Sounds/Play"
@onready var stop: AudioStreamPlayer = $"../../Sounds/Stop"


func _on_play_button_pressed() -> void:
	world_states.send_event("play")
	play.play()


func _on_stop_button_pressed() -> void:
	world_states.send_event("stop")
	stop.play()
