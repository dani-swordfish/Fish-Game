extends Node


func get_component_scene(component: Enum.COMPONENTS) -> String:
	match component:
		Enum.COMPONENTS.CONV_STRAIT:
			return "res://Scenes/Conveyor Components/conveyor.tscn"
		Enum.COMPONENTS.CONV_CORNER:
			return "res://Scenes/Conveyor Components/conveyor.tscn"
		Enum.COMPONENTS.CONV_SPLITTER:
			return ""
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
			return [Enum.ITEMS.TEST_MEAT, Enum.ITEMS.TEST_SCALE, Enum.ITEMS.TEST_FISH]
		_:
			printerr("no recipie for item")
			return []


func get_constuctor_recipe(item: Enum.ITEMS)-> Array[int]:
	match item:
		Enum.ITEMS.TEST_FISH:
			return [Enum.ITEMS.TEST_MEAT, Enum.ITEMS.TEST_SCALE, Enum.ITEMS.TEST_FISH]
		_:
			printerr("no recipie for item")
			return []

