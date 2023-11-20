#@tool
extends Componenet
class_name Conveyor

# contains an item at it's center which it would like to pass on.
@export var has_item_ready: bool = false

@export var item_node: Node2D = null

# has space for a new item.
var has_space: bool:
	get:
		if is_in_group("stores_items"):
			return get_has_space()
		else:
			return has_space

var next_component: Node2D = null



# should do with code instead
@onready var ray_cast_2d: RayCast2D = $RayCast2D


func get_has_space()-> bool:
	printerr("getter on conveyer should not be used, component might be in wrong group")
	return false

#func _on_area_2d_area_entered(area: Area2D) -> void:
	#area.get_parent().direction = direction

func _ready() -> void:
	has_space = true
	super._ready()
	await get_tree().create_timer(0.1).timeout # only needed if run on ready.
	next_component = get_next_component()


# TODO at player start of game
func _physics_process(delta: float) -> void:
	if next_component == null: return
	
	if has_item_ready:
		if next_component.has_space:
			move_item()
	
	#if has_space == false and item_node.position == position:
		#has_item_ready = true
	

# check prosses class items before changing this code
func item_arrived():
	has_item_ready = true



# TODO at player start of game
func get_next_component(raycast = ray_cast_2d, com_direction = direction) -> Node2D:
	if ray_cast_2d == null:
		print("ray cast == null")
		return null
	
	if !raycast.is_colliding():
		return null
	
	var new_component: Node2D = raycast.get_collider().get_parent()
	
	if new_component.is_in_group("direction_matters"):
		for direction in  new_component.get_input_directions_array():
			print(self)
			if direction == com_direction:
				
				return new_component
		return null
	
	return new_component


func move_item(move_direction = direction, new_compnent = next_component, item_to_move = item_node):
	if item_to_move == null:
		printerr(item_to_move, "  is null")
	
	
	# TODO remove component setter and use this maybe
	if new_compnent.is_in_group("stores_items"):
		new_compnent.storage_space += 1
	else:
		new_compnent.has_space = false
	
	
	new_compnent.item_node = item_to_move
	item_to_move.move(move_direction, new_compnent)
	has_item_ready = false
	has_space = true


