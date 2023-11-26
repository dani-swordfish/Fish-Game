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
	
	sprite.frame_coords = Globals.get_component_frame_coords(component)
	# TODO add coords


func has_component() -> bool:
	if component == Enum.COMPONENTS.EMPTY:
		return false
	return true






