extends Control
# TODO could save score

@export var level_no: int = 1

@onready var time_taken_label: Label = $Panel/VBoxContainer/TimeTakenLabel
@onready var component_count_label: Label = $Panel/VBoxContainer/ComponentCountLabel
@onready var level_complete: AudioStreamPlayer = $"../../Sounds/LevelComplete"
@onready var stop_button: Button = $"../ModeUI/PlayStop/MarginContainer/HBoxContainer/StopButton"

var high_score_resource: HighScore = HighScore.new()

@onready var saver: Saver = preload("res://Save System/saver.tres")
func _ready() -> void:
	hide()


func open(time: float, component_count: float):
	load_high_scores()
	time_taken_label.text = str(time)
	component_count_label.text = str(component_count)
	level_complete.play()
	high_score_resource.input(level_no, time, component_count)
	save_high_scores()
	show()


func close():
	stop_button.pressed.emit()
	hide()


func _on_continue_button_pressed() -> void:
	close()


func _on_next_level_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(Globals.level_list[level_no +1])


func load_high_scores():
	if saver.load_game("high_scores.tres") == null:
		print("did not load")
		return
	high_score_resource = saver.load_game("high_scores.tres").duplicate()
	print("did load high scores")


func save_high_scores():
	saver.save_game(high_score_resource.duplicate(), "high_scores.tres")
	print("high score saved", high_score_resource, high_score_resource.levels_array)
