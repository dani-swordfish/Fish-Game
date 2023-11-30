extends Button


signal menu_transition(menu: MenuBase.MENU_TYPE)


@export var in_menu_transition_to: MenuBase.MENU_TYPE = MenuBase.MENU_TYPE.MAIN

@export var in_game_transition_to: MenuBase.MENU_TYPE = MenuBase.MENU_TYPE.IN_GAME




func _on_pressed() -> void:
	for node in get_tree().root.get_children():
		if node.is_in_group("menu_hub"):
			menu_transition.emit(in_menu_transition_to)
			return
	
	menu_transition.emit(in_game_transition_to)
	
	
