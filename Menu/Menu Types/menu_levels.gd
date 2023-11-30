extends MenuType

# TODO check
@export var level_count: int

const level_button: PackedScene = preload("res://Menu/Menu Components/Menu Buttons/level_button.tscn")
@onready var button_container: VBoxContainer = $HBoxContainer/VBoxContainer

@onready var high_score_container: VBoxContainer = $HBoxContainer/VBoxContainer2
var high_score_resource: HighScore = null
const SAVED_NUMBER_LABEL: PackedScene = preload("res://Scenes/UI/saved_number_label.tscn")
@onready var button_and_label_container: GridContainer = %ButtonAndLabelContainer

@onready var saver: Saver = preload("res://Save System/saver.tres")




func open():
	load_high_scores()
	for i in range(1, (level_count +1)):
		var button_inst: Button = level_button.instantiate()
		button_and_label_container.add_child(button_inst)
		button_inst.level_number = i
		button_inst.text = "Level %s" %str(i)
		button_inst.pressed_level.connect(on_button_pressed)
		spawn_labels(i - 1)
	super.open()


func close():
	for child in button_and_label_container.get_children():
		if child.is_in_group("things_to_despawn"):
			child.queue_free()
	super.close()


func on_button_pressed(level_number):
	get_tree().paused = false
	get_tree().change_scene_to_file(Globals.level_list[level_number -1])
	


func spawn_labels(i):
	for j: float in high_score_resource.levels_array[i]:
		spawn_label(j)
	
	

func spawn_label(j: float):
	var label_inst: Label = SAVED_NUMBER_LABEL.instantiate()
	if j == -1:
		label_inst.text = "---"
	else:
		label_inst.text = str(j)
	button_and_label_container.add_child(label_inst)


func load_high_scores():
	if saver.load_game("high_scores.tres") == null:
		high_score_resource = HighScore.new()
		print("did not load")
		return
	high_score_resource = saver.load_game("high_scores.tres").duplicate()
	print("did load high scores")

