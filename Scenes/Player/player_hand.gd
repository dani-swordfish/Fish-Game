extends Control


var component_rotation: float = 0.0

@onready var player_box: Panel = $PlayerBox


func _physics_process(delta: float) -> void:
	position = get_global_mouse_position()
	

func pick_up_componant(component: Enum.COMPONENTS):
	component_rotation = 0.0
	player_box.sprite.rotation_degrees = component_rotation
	
	player_box.component = component
	player_box.set_component()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate"):
		rotate_component()
		
	if event is InputEventMouseButton and \
	event.button_index == MOUSE_BUTTON_RIGHT:
		player_box.component = Enum.COMPONENTS.EMPTY


func rotate_component():
	if !player_box.has_component(): return
	
	var spirte = player_box.sprite
	component_rotation += 90.0
	if component_rotation > 180.0:
		component_rotation -= 360
	spirte.rotation_degrees = component_rotation


# a value of 0 means there is no component
func get_component() -> int:
	return player_box.component
	

func has_component() -> bool:
	if !player_box.has_component():
		return false
	return true
