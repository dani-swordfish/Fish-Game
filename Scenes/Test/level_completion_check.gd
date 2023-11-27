extends Node


const OUTPUT_COUNT_UI: PackedScene = preload("res://Scenes/UI/output_count_ui.tscn")
@onready var v_box_container: VBoxContainer = $"../MarginContainer/VBoxContainer"


func _ready() -> void:
	for output in get_tree().get_nodes_in_group("output"):
		output.connect("output_ready", on_output_ready)


func on_output_ready(item: int, item_count_target: int, output: Node2D):
	spawn_output_count(item, item_count_target, output )


func spawn_output_count(item, item_count_target, output):
	var count_inst = OUTPUT_COUNT_UI.instantiate()
	count_inst.item_count_target = item_count_target
	count_inst.item = item
	v_box_container.add_child(count_inst)
	output.connect("item_arrived_signal", count_inst)


