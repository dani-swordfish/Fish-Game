extends ConveyorSplitter

## stuff for item picker
@export var item: Enum.ITEMS
@export var item_picker_array: Array[Enum.ITEMS]
@export var player_can_pick: bool = true
@export var override_level_default: bool = false
@onready var item_picker_ui: Control = Globals.references.item_picker_ui

var next_component_3: Node2D = null
@onready var ray_cast_2d_3: RayCast2D = $RayCast2D3


func _ready() -> void:
	super._ready()


func _on_play():
	super._on_play()
	next_component_3 = get_next_component(ray_cast_2d_3, get_sorter_direction())
	
	# TODO change to something better
	for child in get_children():
		if child is AnimatedSprite2D:
			child.play()


func _on_stop():
	super._on_stop()
	for child in get_children():
		if child is AnimatedSprite2D:
			child.stop()



func get_sorter_direction() -> int:
	var next_component_3_direction: int = direction - 1
	
	if next_component_3_direction < 0:
		next_component_3_direction += 4
	return next_component_3_direction
	

func _physics_process(delta: float) -> void:
	## functions as a splitter for all other items.
	if has_item_ready:
		if item == item_node.item:
			if next_component_3 == null: 
				return
			if next_component_3.get_has_space(item_node):
				move_item(get_sorter_direction(), next_component_3,)
			return
		else:
			super._physics_process(delta)
			return


