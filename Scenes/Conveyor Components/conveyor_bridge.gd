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


func _on_play():
	super._on_play()
	for child in get_children():
		if child.is_in_group("direction_matters"):
			child._on_play()

func _on_stop():
	super._on_stop()
	for child in get_children():
		if child.is_in_group("direction_matters"):
			child._on_stop()
