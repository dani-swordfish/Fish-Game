extends Node

# number of Outputs in scene
var output_count: int 
var outputs_complete: int

const OUTPUT_COUNT_UI: PackedScene = preload("res://Scenes/UI/output_count_ui.tscn")
@onready var v_box_container: VBoxContainer = $"../MarginContainer/VBoxContainer"
@onready var world_states: StateChart = $"../../../../WorldStates"
@onready var level_complete: Control = $"../../../LevelComplete"


func _ready() -> void:
	for output in get_tree().get_nodes_in_group("output"):
		output.connect("output_ready", on_output_ready)
		output.connect("target_reached", on_target_reached)
		output_count += 1


func on_output_ready(item: int, item_count_target: int, output: Node2D):
	spawn_output_count(item, item_count_target, output )


func spawn_output_count(item, item_count_target, output):
	var count_inst = OUTPUT_COUNT_UI.instantiate()
	count_inst.item_count_target = item_count_target
	count_inst.item = item
	v_box_container.add_child(count_inst)
	output.connect("item_arrived_signal", count_inst.set_current_item)
	v_box_container.move_child(count_inst, 0)


func on_target_reached():
	outputs_complete += 1
	
	if outputs_complete >= output_count:
		var componenet_count: int = get_parent().get_component_count()
		var time_taken = get_parent().round_to_dec(get_parent().time_taken, 2)
		level_complete.open(time_taken, componenet_count)
		world_states.send_event("stop")
		print("level_complete")


func _on_play_state_exited() -> void:
	outputs_complete = 0
