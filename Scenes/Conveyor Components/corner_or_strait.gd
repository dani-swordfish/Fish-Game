extends Conveyor


#@onready var conveyor_sprite: Sprite2D = $ConveyorSprite
@onready var conveyor_animation: AnimatedSprite2D = $ConveyorAnimation


@export var corner: bool:
	set(value):
		corner = value
		if corner:
			$AnimatedSprite2D.animation = "corner"
		else:
			$AnimatedSprite2D.animation = "strait"


@export var flipped: bool:
	set(value):
		flipped = value
		if flipped:
			$ConveyorSprite.flip_v = true
		else:
			$ConveyorSprite.flip_v = false

func _ready() -> void:
	super._ready()
	if corner:
		$ConveyorAnimation.animation = "corner"
	else:
		$ConveyorAnimation.animation = "strait"


#func _on_play():
	#super._on_play()
	#
#
#func _on_stop():
	#super._on_stop()
	#

