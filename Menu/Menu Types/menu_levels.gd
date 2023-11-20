extends MenuType

@export var level_count: int

const level_button: PackedScene = preload("res://Menu/Menu Components/Menu Buttons/level_button.tscn")
@onready var button_container: GridContainer = $ButtonContainer

func _ready() -> void:
	for i in range(1, (level_count +1)):
		var button_inst: Button = level_button.instantiate()
		button_container.add_child(button_inst)
		button_inst.level_number = i
		button_inst.text = "Level %s" %str(i)
		button_inst.pressed_level.connect(on_button_pressed)


func on_button_pressed(level_number):
	pass
	print(level_number)
	
	## example code for changing level
#	get_tree().paused = false
#	get_tree().change_scene_to_file(Global.level_list[level_number -1])
