extends Node

@onready var references: Node2D:
	get:
		return get_parent().get_children().back().get_node("References")


func get_component_scene(component: Enum.COMPONENTS) -> String:
	match component:
		Enum.COMPONENTS.CONV_STRAIT:
			return "res://Scenes/Conveyor Components/conveyor.tscn"
		Enum.COMPONENTS.CONV_CORNER:
			return "res://Scenes/Conveyor Components/conveyor.tscn"
		Enum.COMPONENTS.CONV_SPLITTER:
			return "res://Scenes/Conveyor Components/conveyor_split.tscn"
		Enum.COMPONENTS.CONV_SORTER:
			return "res://Scenes/Conveyor Components/conveyor_sorter.tscn"
		Enum.COMPONENTS.CONV_BRIDGE:
			return "res://Scenes/Conveyor Components/conveyor_bridge.tscn"
		Enum.COMPONENTS.SPAWNER:
			return "res://Scenes/Components/spawner.tscn"
		Enum.COMPONENTS.CUTTER:
			return "res://Scenes/Components/cutter.tscn"
		Enum.COMPONENTS.CONSTRUCTOR:
			return "res://Scenes/Components/constructor.tscn"
		Enum.COMPONENTS.BIN:
			return "res://Scenes/Conveyor Components/bin.tscn"
		Enum.COMPONENTS.OUTPUT:
			return "res://Scenes/Conveyor Components/output.tscn"
		Enum.COMPONENTS.RANDI_CUTTER:
			return "res://Scenes/Components/randi_cutter.tscn"
			
		_:
			printerr("component scene not found")
			return ""


func get_item_frame_coords(item: Enum.ITEMS) -> Vector2:
	match item:
		## Salmon
		Enum.ITEMS.SALMON:
			return Vector2(0,0)
		Enum.ITEMS.SALMON_SCALE:
			return Vector2(1,0)
		Enum.ITEMS.SALMON_MEAT:
			return Vector2(2,0)
		Enum.ITEMS.RICE:
			return Vector2(3,0)	
		Enum.ITEMS.SEAWEED:
			return Vector2(4,0)
		Enum.ITEMS.SALMON_SUSHI:
			return Vector2(5,0)
		
		## Angler
		Enum.ITEMS.ANGLER:
			return Vector2(0,1)
		Enum.ITEMS.ANGLER_SCALE:
			return Vector2(1,1)
		Enum.ITEMS.LIGHT_BULB:
			return Vector2(2,1)
		_:
			printerr("item frame_coords not found")
			return Vector2(0,0)


func get_component_frame_coords(component):
	match component:
		Enum.COMPONENTS.CONV_STRAIT:
			return Vector2(0,0)
		Enum.COMPONENTS.CONV_CORNER:
			return Vector2(1,0)
		Enum.COMPONENTS.CONV_SPLITTER:
			return Vector2(1,1)
		Enum.COMPONENTS.CONV_SORTER:
			return Vector2(0,2)
		Enum.COMPONENTS.CONV_BRIDGE:
			return Vector2(2,2)
		Enum.COMPONENTS.SPAWNER:
			return Vector2(2,0)
		Enum.COMPONENTS.CUTTER:
			return Vector2(2,1)
		Enum.COMPONENTS.CONSTRUCTOR:
			return Vector2(1,2)
		Enum.COMPONENTS.BIN:
			return Vector2(3,0)
		Enum.COMPONENTS.OUTPUT:
			return Vector2(0,1)
		Enum.COMPONENTS.RANDI_CUTTER:
			return Vector2(3,1)
		Enum.COMPONENTS.REMOVE_COMPONENT:
			return Vector2(0,3)

## can have no more than 3 items recipe per recipe, randi_cutter could take more level specific
func get_cutter_recipe(item: Enum.ITEMS)-> Array[Array]:
	match item:
		Enum.ITEMS.SALMON:
			return [[Enum.ITEMS.SALMON_MEAT, 1], [Enum.ITEMS.SALMON_SCALE, 2]]
		
		Enum.ITEMS.ANGLER:
			return [[Enum.ITEMS.ANGLER_SCALE, 2], [Enum.ITEMS.LIGHT_BULB, 1]]
		_:
			printerr("no recipie for item")
			return []


func get_constuctor_recipe(item: Enum.ITEMS)-> Array[Array]:
	match item:
		Enum.ITEMS.SALMON:
			return [[Enum.ITEMS.SALMON_MEAT, 1], [Enum.ITEMS.SALMON_SCALE, 2]]
		
		Enum.ITEMS.SALMON_SUSHI:
			return [[Enum.ITEMS.SALMON_MEAT, 1], [Enum.ITEMS.RICE, 2], [Enum.ITEMS.SEAWEED, 1]]
		_:
			printerr("no recipie for item")
			return []
		

func get_opposite_direction(direction)-> int:
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
			return 0

func get_fixed_direction(direction: int) -> Enum.DIRECTION:
	if direction < 0:
			direction += 4
	elif direction > 3:
			direction -= 4
	return direction
	


