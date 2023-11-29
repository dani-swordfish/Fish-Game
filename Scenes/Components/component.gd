#@tool
extends Node2D
class_name Componenet

var component: Enum.COMPONENTS
var direction: Enum.DIRECTION
var tile: Vector2i

@onready var sprite_background: Sprite2D = $SpriteBackground

@export var is_static: bool = true


func _ready() -> void:
	if is_static:
		sprite_background.show()
	else:
		sprite_background.hide()
	
	set_direction()
	set_physics_process(false)
	
	# only need for tiles which start on the level
	set_tile()

func set_tile():
	tile = Globals.references.tilemap.local_to_map(position)


func _components_changed():
	pass


func _on_play():
	set_physics_process(true)


func _on_stop():
	set_physics_process(false)



func set_direction():
	var rotation_value: float = round(rad_to_deg(global_rotation)) 
	direction = match_rotaion(rotation_value)

func match_rotaion(rotation_value: float) -> int:
	var new_direction: int = 0
	
	match rotation_value:
		0.0:
			new_direction = Enum.DIRECTION.E
		90.0:
			new_direction = Enum.DIRECTION.S
		180.0:
			new_direction = Enum.DIRECTION.W
		-180.0:
			new_direction = Enum.DIRECTION.W
		-90.0:
			new_direction = Enum.DIRECTION.N
		_:
			printerr("invalid conveyor rotation")
	
	return new_direction
