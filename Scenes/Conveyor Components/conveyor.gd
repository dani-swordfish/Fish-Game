#@tool
extends Componenet
class_name Conveyor

# contains an item at it's center which it would like to pass on.
@export var has_item_ready: bool = false

@export var item_node: Node2D = null

# has space for a new item.
var has_space: bool = true
	#get:
		#if is_in_group("stores_items"):
			#return get_has_space()
		#else:
			#return has_space

var next_component: Node2D = null



# should do with code instead
@onready var ray_cast_2d: RayCast2D = $RayCast2D


func get_has_space(item_node_received)-> bool:
	return has_space

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
		if next_component.get_has_space(item_node):
			move_item()
	
	#if has_space == false and item_node.position == position:
		#has_item_ready = true
	

# check prosses class items before changing this code
# do not use arrived_item_node unless distroying it!!!
func item_arrived(arrived_item_node):
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
		if new_component.is_in_group("test"):
			print("tried", com_direction, new_component.get_input_directions_array())
		if com_direction in new_component.get_input_directions_array():
			if new_component.is_in_group("test"):
				print("success", new_component)
			return new_component
		return null
	
	return new_component


func move_item(move_direction = direction, new_compnent = next_component, item_to_move = item_node):
	if item_to_move == null:
		printerr(item_to_move, "  is null")
	
	
	# TODO select correct storage if stores multiple items ##test
	if new_compnent.is_in_group("stores_items"):
		if new_compnent.storage_array[0].any_item:
			new_compnent.storage_array[0].storage_space += 1
		else:
			for i in new_compnent.storage_array.size():
				if new_compnent.storage_array[i].item == item_to_move.item:
					new_compnent.storage_array[i].storage_space += 1
			
	else:
		new_compnent.has_space = false
	
	if new_compnent.is_in_group("takes_multiple_items"):
		#new_compnent.item_nodes_array.append(item_to_move)
		pass
	else:
		new_compnent.item_node = item_to_move
	
	item_to_move.move(move_direction, new_compnent)
	has_item_ready = false
	has_space = true


