extends Node


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
			
		_:
			printerr("component scene not found")
			return ""


func get_item_frame_coords(item: Enum.ITEMS) -> Vector2:
	match item:
		Enum.ITEMS.TEST_FISH:
			return Vector2(0,0)
		Enum.ITEMS.TEST_SCALE:
			return Vector2(1,0)
		Enum.ITEMS.TEST_MEAT:
			return Vector2(2,0)
		_:
			printerr("item frame_coords not found")
			return Vector2(0,0)


## item recipes
func get_cutter_recipe(item: Enum.ITEMS)-> Array[int]:
	match item:
		Enum.ITEMS.TEST_FISH:
			return [Enum.ITEMS.TEST_MEAT, Enum.ITEMS.TEST_SCALE]
		_:
			printerr("no recipie for item")
			return []


func get_constuctor_recipe(item: Enum.ITEMS)-> Array[int]:
	match item:
		Enum.ITEMS.TEST_FISH:
			return [Enum.ITEMS.TEST_MEAT, Enum.ITEMS.TEST_SCALE]
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
	


