@tool
extends Node2D
class_name Componenet

var component: Enum.COMPONENTS
var direction: Enum.DIRECTION
var tile: Vector2i

@onready var sprite_background: Sprite2D = $SpriteBackground

@export var is_static: bool:
	set(value):
		is_static = value
		if is_static:
			$SpriteBackground.show()
		else:
			$SpriteBackground.hide()


func _ready() -> void:
	var test = is_static
	is_static = test
	set_direction()
	
	

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