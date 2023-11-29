extends Output
# always duplicate, never spawn, to make signals work

signal output_ready(item:int, item_count_target: int, output: Node2D)
signal item_arrived_signal(current_item_count: int)
signal target_reached(item:int)

@export var item: Enum.ITEMS
@export var item_count_target: int = 10


@onready var item_picker_sprite: Node2D = $ItemPickerSprite

# TODO pass to UI
var item_count: int = 0


func _ready() -> void:
	super._ready()
	item_picker_sprite.get_child(1).frame_coords = Globals.get_item_frame_coords(item)
	await get_tree().physics_frame
	output_ready.emit(item, item_count_target, self)
	item_picker_sprite.get_child(1).global_rotation = 0


func get_has_space(item_node_received)-> bool:
	if !item_node_received.item == item:
		print("item type reject")
		return false
	else:
		return super.get_has_space(item_node_received)



func _on_stop():
	super._on_stop()
	item_count = 0
	item_arrived_signal.emit(item_count)


func item_arrived(arrived_item_node):
	if item_node == null:
		return
	
	if item_node.item == item:
		item_count += 1
		
		item_arrived_signal.emit(item_count)
		if item_count == item_count_target:
			target_reached.emit()
	else:
		print("wrong item in output")
		pass # could add gameplay outcome
	super.item_arrived(arrived_item_node)
	
	
