extends Node


@onready var conveyor_belt: AudioStreamPlayer = $ConveyorBelt


func _on_play_state_entered() -> void:
	conveyor_belt.play()


func _on_play_state_exited() -> void:
	conveyor_belt.stop()
