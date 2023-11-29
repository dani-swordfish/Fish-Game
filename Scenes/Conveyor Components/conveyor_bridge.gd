extends Componenet
# TODO player can flip whilst placing
# test more
# asthetics? hide one item?
@onready var conveyor_2: Node2D = $Conveyor2
@export var flipped: bool = false
@onready var top_down_conveyor: Sprite2D = $"Top-down-conveyor"


func _ready() -> void:
	if flipped:
		conveyor_2.rotation_degrees += 180
		top_down_conveyor.flip_v = true
	conveyor_2.set_direction()
	


func _on_play():
	super._on_play()
	for child in get_children():
		if child.is_in_group("direction_matters"):
			child._on_play()


func _components_changed():
	super._components_changed()
	for child in get_children():
		if child.is_in_group("direction_matters"):
			child._components_changed()


func _on_stop():
	super._on_stop()
	for child in get_children():
		if child.is_in_group("direction_matters"):
			child._on_stop()
