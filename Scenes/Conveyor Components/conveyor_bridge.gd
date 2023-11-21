extends Componenet
# TODO player can flip whilst placing
# test more
# asthetics? hide one item?
@onready var conveyor_2: Node2D = $Conveyor2
@export var flipped: bool = false


func _ready() -> void:
	if flipped:
		conveyor_2.rotation_degrees += 180
	conveyor_2.set_direction()
