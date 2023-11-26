extends Conveyor
class_name ConveyorSplitter

var split: bool
var next_component_2: Node2D = null

@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2

func _ready() -> void:
	super._ready()
	

func _on_play():
	super._on_play()
	next_component_2 = get_next_component(ray_cast_2d_2, get_splitter_direction())




## for direction_matters group
func get_input_directions_array()-> Array[int]:
	var input_direction = (direction - 1)
	if input_direction < 0:
		input_direction += 4
	var array: Array[int] = [input_direction]
	return array


func _physics_process(delta: float) -> void:
	if next_component == null and next_component_2 == null: return
	
	if next_component == null:
		if has_item_ready:
			if next_component_2.get_has_space(item_node):
				move_item(get_splitter_direction(), next_component_2)
			return
	
	if next_component_2 == null:
		if has_item_ready:
			if next_component.get_has_space(item_node):
				move_item()
			return
	
	if has_item_ready:
		if next_component.get_has_space(item_node) and next_component_2.get_has_space(item_node):
			if split:
				move_item()
				split = false
			else:
				move_item(get_splitter_direction(), next_component_2)
			return
		
		if next_component.get_has_space(item_node):
			move_item()
			split = false
			return
		if next_component_2.get_has_space(item_node):
			move_item(get_splitter_direction(), next_component_2)
			split = true
			return


func get_splitter_direction()-> int:
	split = true
	match direction:
		Enum.DIRECTION.N:
			return Enum.DIRECTION.S
		Enum.DIRECTION.E:
			return Enum.DIRECTION.W
		Enum.DIRECTION.S:
			return Enum.DIRECTION.N
		Enum.DIRECTION.W:
			return Enum.DIRECTION.E
		_:
			printerr("splitter invalid direction  ", direction)
			return 0
		
