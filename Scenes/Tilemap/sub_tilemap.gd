extends TileMap





func get_component_pos()-> Vector2i:
	var tile: Vector2 = map_to_local(local_to_map(to_local(get_global_mouse_position())))
	
	return tile

