extends Resource
class_name HighScore

# TODO should match level number

# [time, component_count]
@export var levels_array: Array[Array] = [
	[-1.0,-1.0],
	[-1.0,-1.0],
	[-1.0,-1.0],
	[-1.0,-1.0],
	[-1.0,-1.0],
	[-1.0,-1.0],
	[-1.0,-1.0],
	[-1.0,-1.0],
]


func input(level_no: int, time: float, component_count:float):
	var level_array = levels_array[level_no - 1]
	level_array[0] = get_smallest(level_array[0], time)
	level_array[1] = get_smallest(level_array[1], component_count)


func get_smallest(level:int, item: float)-> float:
	if level == -1.0:
			return item
		
	elif item < level:
		return item
	return level

