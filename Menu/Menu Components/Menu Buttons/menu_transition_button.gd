extends Button

signal menu_transition(menu: MenuBase.MENU_TYPE)


@export var transition_to: MenuBase.MENU_TYPE


func _on_pressed() -> void:
	menu_transition.emit(transition_to)

