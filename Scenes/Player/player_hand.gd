extends Control

signal player_picked_up_component
signal player_dropped_component


var component_rotation: float = 0.0
var active_box: Panel

@onready var player_box: Panel = $PlayerBox

func _ready() -> void:
	clear_component()


func _on_play_state_entered() -> void:
	clear_component()

func _physics_process(delta: float) -> void:
	position = get_global_mouse_position()
	

# should alway pick up, if return is added count will be wrong, check box code
func pick_up_componant(component: Enum.COMPONENTS, _active_box):
	active_box = _active_box
	component_rotation = 0.0
	player_box.sprite.rotation_degrees = component_rotation
	
	player_box.component = component
	player_box.sprite.flip_v = false
	player_box.set_component()
	player_box.show()
	player_picked_up_component.emit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate"):
		rotate_component()
	
	if event.is_action_pressed("flip"):
		flip_component()
	
	if event is InputEventMouseButton and \
	event.button_index == MOUSE_BUTTON_RIGHT:
		clear_component()

func clear_component():
	player_box.component = Enum.COMPONENTS.EMPTY
	
	active_box = null
	player_box.hide()
	player_dropped_component.emit()


func rotate_component():
	if !player_box.has_component(): return
	
	var spirte = player_box.sprite
	component_rotation += 90.0
	if component_rotation > 180.0:
		component_rotation -= 360
	spirte.rotation_degrees = component_rotation


func flip_component():
	if !player_box.has_component(): return
	
	if player_box.component == Enum.COMPONENTS.CONV_CORNER \
	or player_box.component == Enum.COMPONENTS.CONV_BRIDGE:
		player_box.sprite.flip_v = !player_box.sprite.flip_v
	


# a value of 0 means there is no component
func get_component() -> int:
	return player_box.component
	

func has_component() -> bool:
	if !player_box.has_component():
		return false
	return true


