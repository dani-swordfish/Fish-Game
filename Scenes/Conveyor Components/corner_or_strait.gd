extends Conveyor


#@onready var conveyor_sprite: Sprite2D = $ConveyorSprite

@export var corner: bool:
	set(value):
		corner = value
		if corner:
			$ConveyorSprite.frame_coords = Vector2(1,0)
		else:
			$ConveyorSprite.frame_coords = Vector2(0,0)
