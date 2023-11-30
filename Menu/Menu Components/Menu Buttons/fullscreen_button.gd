extends Button
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"

func _ready() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		button_pressed = true
		text = "Windowed"
	else:
		button_pressed = false
		text = "Fullscreen"
	


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		text = "Windowed"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		audio_stream_player.play()
	if !toggled_on:
		text = "Fullscreen"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		audio_stream_player.play()
