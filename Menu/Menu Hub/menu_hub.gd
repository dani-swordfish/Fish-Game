extends MenuBase
class_name MenuHub

@export var default_menu: MENU_TYPE = MENU_TYPE.MAIN

var current_menu: MENU_TYPE

@onready var menus: Control = $Menus
@onready var menu_music: AudioStreamPlayer = $MenuMusic


func _ready() -> void:
	for child in get_tree().get_nodes_in_group("menu_transition_button"):
		child.menu_transition.connect(on_menu_transition_button)
	get_tree().paused = false
	initialise()
	for node in get_tree().root.get_children():
		if node.is_in_group("menu_hub"):
			menu_music.play()


# runs on ready and open
func initialise():
	change_menu(default_menu)


func on_menu_transition_button(menu):
	%Click.play()
	change_menu(menu)


# could instantiate menus, feels like overkill
# could close only current menu
func change_menu(new_menu_type: MENU_TYPE):
	current_menu = new_menu_type
	if current_menu == MENU_TYPE.CLOSE:
		close()
		return
	
	var open_menues: int = 0
	for menu in menus.get_children():
		if menu.menu_type == current_menu:
			menu.open()
			open_menues += 1
		else:
			menu.close()
	
	if open_menues == 0:
		printerr("menu_hub tried to open menu which does not exist, no menu has been opened")
	elif open_menues > 1:
		printerr("menu_hub has opened two menues or more at the same time, probably they are set to the same type")


func open():
	initialise()
	get_tree().paused = true
	show()
	

# could cause issues if the game should already have been paused, 
# for example on opening menu hub from inventory menu, check when using
func close():
	hide()
	get_tree().paused = false
	for menu in menus.get_children():
		menu.close()
	
	## example
	# if inventory.is_open:
	#	don't unpause
	
