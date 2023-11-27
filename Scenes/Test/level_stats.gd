extends PanelContainer


var time_taken: float = 0.0

@onready var time_taken_label: Label = $MarginContainer/VBoxContainer/HBoxContainer3/TimeTakenLabel
@onready var components: Node2D = $"../../../Components"
@onready var component_count_label: Label = $MarginContainer/VBoxContainer/ComponentCountLabel


func _ready() -> void:
	set_physics_process(false)
	time_taken = 0
	update_component_label()


func _physics_process(delta: float) -> void:
	time_taken += delta
	time_taken_label.text = str(round_to_dec(time_taken, 2))


func round_to_dec(num, digit)-> float:
	return round(num * pow(10.0, digit)) / pow(10.0, digit)


func _on_play_state_entered() -> void:
	set_physics_process(true)


func _on_play_state_exited() -> void:
	set_physics_process(false)
	time_taken = 0


func _on_sub_machine_after_components_changed() -> void:
	update_component_label()


func update_component_label():
	var component_count:int
	for component in components.get_children():
		if !component.is_static:
			component_count += 1
	component_count_label.text = str(component_count)


