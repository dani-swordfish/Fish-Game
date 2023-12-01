extends Control



@onready var hint_button: Button = $"../ComponentPicker/HintButton"

@onready var mouse_click: AudioStreamPlayer = $"../../Sounds/MouseClick"

func _ready() -> void:
	close()


func open():
	show()


func close():
	hide()


func _on_hint_button_pressed() -> void:
	mouse_click.play()
	open()

func _on_continue_button_pressed() -> void:
	mouse_click.play()
	close()


func _on_play_state_entered() -> void:
	hint_button.disabled = true


func _on_play_state_exited() -> void:
	hint_button.disabled = false



