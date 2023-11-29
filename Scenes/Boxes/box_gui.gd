extends Box

@export var initial_component_count: int = 0

# TODO make work
@export var is_infinate: bool = false

var component_count:int:
	set(value):
		component_count = value
		if is_infinate:
			return
		
		count_label.text = "x" + str(component_count)
		if component_count <= 0:
			modulate = Color(0.49, 0.49, 0.49)
		else:
			modulate = Color(1,1,1)
@onready var select_component: AudioStreamPlayer = $"../../../../../../../../../../Sounds/SelectComponent"

# could change to global reference if boxes are spawned
@onready var references: Node2D = %References
@onready var count_label: Label = $PanelContainer/CountLabel

func _ready() -> void:
	super._ready()
	if is_infinate:
		count_label.get_parent().hide()
	component_count = initial_component_count



# TODO also on number hotkey
func _on_gui_input(event: InputEvent) -> void:
	if references.world_states.get_child(0)._active_state == null:
		return
	if references.world_states.get_child(0)._active_state.name == "Play":
		return
	
	# TODO check maybe remove
	#if component_count <= 0:
		#return
	
	if event is InputEventMouseButton \
	and event.is_pressed():
		print("test")
		if event.button_index == MOUSE_BUTTON_LEFT:
			player_hand.pick_up_componant(component, self)
			select_component.play()

