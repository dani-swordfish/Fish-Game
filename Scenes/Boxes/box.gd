extends Panel
class_name Box

@export var component: Enum.COMPONENTS
@onready var sprite: Sprite2D = $Sprite
@onready var player_hand: Control = %PlayerHand

func _ready() -> void:
	set_component()

func set_component():
	if !has_component():
		sprite.hide()
		return
	
	sprite.show()
	match component:
		Enum.COMPONENTS.CONV_STRAIT:
			sprite.frame_coords = Vector2(0,0)
		Enum.COMPONENTS.CONV_CORNER:
			sprite.frame_coords = Vector2(1,0)
		Enum.COMPONENTS.CONV_SPLITTER:
			sprite.frame_coords = Vector2(2,0)


func has_component() -> bool:
	if component == Enum.COMPONENTS.EMPTY:
		return false
	return true






