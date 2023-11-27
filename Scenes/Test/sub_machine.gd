extends Control

# needs to happen only once, not twice if changed and removed both happen
signal components_changed

signal before_components_changed
signal after_components_changed


@onready var player_hand: Control = %PlayerHand
@onready var tilemap = %Tilemap
@onready var components: Node2D = $"../Components"
@onready var world_states: StateChart = $"../WorldStates"




func _on_play_state_entered() -> void:
	pass # Replace with function body.


func _on_gui_input(event: InputEvent) -> void:
	if Globals.references.world_states.get_child(0)._active_state == null:
		return
	
	if Globals.references.world_states.get_child(0)._active_state.name == "Play":
		return
	
	if !event is InputEventMouseButton:
		return
	
	if !player_hand.has_component():  
		print("player has no compoenent")
		return
	
	
	if event.is_pressed() \
	and event.button_index == MOUSE_BUTTON_LEFT:
		if player_hand.get_component() == Enum.COMPONENTS.REMOVE_COMPONENT:
			if remove_component():
				handle_signals()
			return
		
		spawn_component(player_hand.get_component())
		
		
		

func handle_signals():
	before_components_changed.emit()
	await get_tree().create_timer(0.05).timeout
	components_changed.emit()
	await get_tree().create_timer(0.05).timeout
	after_components_changed.emit()



func remove_component() -> bool:
	for cov in components.get_children():
		if cov.tile == tilemap.get_component_pos():
			if !cov.is_static:
				get_box_and_count_up(cov)
				cov.queue_free()
				return true
			else:
				print("tried to remove static component")
				return false
	return false


func get_box_and_count_up(component):
	for box in Globals.references.h_box_container.get_children():
		if box is Box\
		and box.component == component.component:
			box.component_count += 1


func spawn_component(component: int):
	if Globals.get_component_scene(component) == "":
		printerr("invalid component")
		return
	
	if player_hand.active_box.component_count <= 0:
		return
	
	
	# check tile if tile is being used by imovable component
	for cov in components.get_children():
		if cov.tile == tilemap.get_component_pos():
			#print(cov.tile, tilemap.get_component_pos(), "is eqaul??" )
			if !cov.is_static:
				remove_component()
			else:
				print("tried to place component on top of static component")
				return
	
	## should only run if spawning happens
	var component_scene: PackedScene = load(Globals.get_component_scene(component))
	var component_inst: Node2D = component_scene.instantiate()
	component_inst.position = tilemap.map_to_local(tilemap.get_component_pos())
	component_inst.global_rotation_degrees = player_hand.component_rotation
	if component == Enum.COMPONENTS.CONV_CORNER:
		component_inst.corner = true
		
	if component == Enum.COMPONENTS.CONV_CORNER or component == Enum.COMPONENTS.CONV_BRIDGE:
		if player_hand.player_box.sprite.flip_v:
			component_inst.flipped = true
	
	components.add_child(component_inst)
	component_inst.is_static = false
	component_inst.tile = tilemap.get_component_pos()
	
	# IMPORTANT components placed befor the level don't know their component and therefore can't be used, could fix
	component_inst.component = player_hand.active_box.component
	
	# reduce component count
	player_hand.active_box.component_count -= 1
	
	handle_signals()


func _on_player_hand_player_picked_up_component() -> void:
	open()


func open():
	show()
	

func _on_player_hand_player_dropped_component() -> void:
	close()
	

func close():
	hide()











