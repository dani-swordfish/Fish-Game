extends Control


@onready var player_hand: Control = %PlayerHand
@onready var sub_tilemap: TileMap = $SubTilemap
@onready var conveyor_belts: Node2D = $ConveyorBelts


func _on_gui_input(event: InputEvent) -> void:
	# TODO return if not in buid mode,
	
	if !event is InputEventMouseButton:
		return
	
	if !player_hand.has_component():  
		print("player has no compoenent")
		return
	
	if event.is_pressed() \
	and event.button_index == MOUSE_BUTTON_LEFT:
		spawn_component(player_hand.get_component())
		print("spawn component")


func spawn_component(component: int):
	if Globals.get_component_scene(component) == "":
		print("invalid component")
		return
	
	
	# check tile if tile is being used by imovable component
	for cov in conveyor_belts.get_children():
		if cov.tile == sub_tilemap.get_component_pos():
			if !cov.is_static:
				cov.queue_free()
			else:
				print("tried to place component on top of static component")
				return
	
	## should only run if spawning happens
	
	print(Globals.get_component_scene(component))
	var component_scene: PackedScene = load(Globals.get_component_scene(component))
	var component_inst: Node2D = component_scene.instantiate()
	component_inst.position = sub_tilemap.get_component_pos()
	component_inst.global_rotation_degrees = player_hand.component_rotation
	if component == Enum.COMPONENTS.CONV_CORNER:
		component_inst.corner = true
	conveyor_belts.add_child(component_inst)
	component_inst.is_static = false
	component_inst.tile = sub_tilemap.get_component_pos()
	
	
	






