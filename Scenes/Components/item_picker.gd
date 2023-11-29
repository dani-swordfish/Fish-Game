extends Control


@onready var item_picker_sprite: Node2D = $"../ItemPickerSprite"


func _ready() -> void:
	update_item(get_parent().item)
	set_level_options()
	item_picker_sprite.get_child(1).global_rotation = 0
	

func set_level_options():
	if get_parent().override_level_default: 
		if get_parent().item_picker_array.size() == 0:
			printerr("Object with override_level_default for item picker has an empty array")
		return
	if get_parent().is_in_group("spawner"):
		get_parent().item_picker_array = Globals.references.level_root.options.spawner_options
	if get_parent().is_in_group("conveyor_sorter"):
		get_parent().item_picker_array = Globals.references.level_root.options.sorter_options
	if get_parent().is_in_group("constructor"):
		get_parent().item_picker_array = Globals.references.level_root.options.constructor_options
		
	if get_parent().item_picker_array.size() == 0:
		printerr("default level options is trying to assign and empty array to an item picker")
	

func _on_gui_input(event: InputEvent) -> void:
	if !get_parent().player_can_pick: return
	if Globals.references.player_hand.has_component(): return
	if Globals.references.world_states.get_child(0)._active_state == null: return
	if Globals.references.world_states.get_child(0)._active_state.name == "Play": return
	
	if event is InputEventMouseButton \
	and event.is_pressed() \
	and event.button_index == MOUSE_BUTTON_LEFT:
		get_parent().item_picker_ui.open(get_parent().item_picker_array, self)


func update_item(item):
	get_parent().item = item
	item_picker_sprite.get_child(1).frame_coords = Globals.get_item_frame_coords(item)
	#if get_parent().has_method("item_updated"):
		#get_parent().item_updated()
