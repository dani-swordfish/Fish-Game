extends Conveyor


#func set_direction():
	#await get_tree().create_timer(0.05).timeout
	#direction = get_parent().direction
	#if is_in_group("sub_2"):
		#direction = (get_parent().direction - 1)
		#direction = Globals.get_fixed_direction(direction)
		#print("set", direction, self)


func get_input_directions_array()-> Array[int]:
	var output_direction: Array[int] = []
	output_direction = [direction]
	return output_direction
