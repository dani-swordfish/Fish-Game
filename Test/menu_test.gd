extends Node2D


@onready var menu_hub: Control = %MenuHub


func _ready() -> void:
	menu_hub.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		menu_hub.open()
