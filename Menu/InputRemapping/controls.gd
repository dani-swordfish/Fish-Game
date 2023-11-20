extends MenuType
# TODO add controllers support
# will always fail with more than two events for one action. / so don't do that
signal back_button_pressed


# actions user can remap
@export var action_array: ActionArray
# action for which their events can't be used by other actions during remapping
# for example using "ui_cancel" stops the Escape key being used by any other action
@export var actions_to_reject_event_remap: Array[String] = ["ui_cancel"]


@onready var input_remap: PackedScene = preload("res://Menu/InputRemapping/input_remap.tscn")
@onready var input_remap_container: VBoxContainer = %InputRemapContainer
@onready var user_warning: Label = $UserWarning
@onready var warning_timer: Timer = $UserWarning/WarningTimer

@onready var saver = preload("res://Save System/saver.tres")

var is_remaping: bool
var action_to_remap = null
var event_index: int = 0



func _on_menu_button_pressed() -> void:
	back_button_pressed.emit()

# functions can be used if input remapper is being used in an ingame menu
func open():
	start()
	super.open()


func close():
	super.close()
	for item in input_remap_container.get_children():
		item.queue_free()
	

func _ready() -> void:
	start()

# runs on open and ready
func start():
	load_actions()
	create_action_list()
	user_warning.hide()


func create_action_list():
	for item in input_remap_container.get_children():
		item.queue_free()
	
	for action_description in action_array.action_array:
		var action = action_description.action
		if !InputMap.has_action(action):
			push_warning("Action %s does not exist from input remapper" % action)
			return
		
		var remap_inst = input_remap.instantiate()
		input_remap_container.add_child(remap_inst)
		var label = remap_inst.action_label
		var button = remap_inst.button_input
		var button_2 = remap_inst.button_input_2
		
		label.text = action_description.description
		
		var events: Array[InputEvent] = InputMap.action_get_events(action)
		
		if events.size() > 0:
			button.text = events[0].as_text().trim_suffix(" (Physical)")
			if events.size() > 1:
				button_2.text = events[1].as_text().trim_suffix(" (Physical)")
		else:
			button.text = ""
		
		button.pressed.connect(_on_input_button_pressed.bind(button, action, 0))
		button_2.pressed.connect(_on_input_button_pressed.bind(button_2, action, 1))


# prevents overwriting other actions events, but not its own.
# this allows, setting an action to two iditical events therefore removing the duplicate 
# and setting the event to the same one as you started with
func get_events_used_by_other_actions(action_to_ignore: String)-> Array[String]:
	var used_events: Array[String] = []
	for action_description in action_array.action_array:
		var action = action_description.action
		if action == action_to_ignore: continue
		for event in InputMap.action_get_events(action):
			used_events.append(event.as_text().trim_suffix(" (Physical)"))
	return used_events


func _on_input_button_pressed(button, action, button_number: int):
	if !is_remaping:
		is_remaping = true
		action_to_remap = action
		event_index = button_number
		button.text = "Press Key to Bind..."


func _input(event: InputEvent) -> void:
	if is_remaping:
		
		# prevents double click being used as an input.
		# should stay at the top of the input function
		if event is InputEventMouseButton and event.double_click:
			event.double_click = false
		
		
		# comment about actions_to_reject_event_remap explains
		for action in actions_to_reject_event_remap:
			if event.is_action_pressed(action):
				accept_event()
				if user_warning.is_visible_in_tree():
					return
				user_warning.text = "Key is not available."
				user_warning.show()
				warning_timer.start()
				return
		
		# prevents reusing events and warns user
		if event.as_text().trim_suffix(" (Physical)") in get_events_used_by_other_actions(action_to_remap):
			accept_event()
			if user_warning.is_visible_in_tree():
				print("visible")
				return
			user_warning.text = "Key is already being used."
			user_warning.show()
			warning_timer.start()
			return
		
		
		# pressed check is needed as input triggers on pressed and released
		if (event is InputEventKey || event is InputEventMouseButton) and event.pressed:
			if InputMap.action_get_events(action_to_remap).size() >= (event_index + 1):
				var event_to_remap = InputMap.action_get_events(action_to_remap)[event_index]
				InputMap.action_erase_event(action_to_remap, event_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			
			
			# hacky solution to get events to display in the correct order
			# affects events order and display, event order has no effect on events themselves
			# will fail with more than 2 events per action
			if event_index == 0:
				var event_to_move = InputMap.action_get_events(action_to_remap)[0]
				InputMap.action_erase_event(action_to_remap, event_to_move)
				InputMap.action_add_event(action_to_remap, event_to_move)
			
			create_action_list()
			save_actions()
			
			is_remaping = false
			action_to_remap = null
			
			accept_event()


func save_actions():
	for action_description in action_array.action_array:
		var action = action_description.action
		var events: Array[InputEvent] = InputMap.action_get_events(action)
		action_description.events = events
	saver.save_game(action_array, "input_remap.tres")
	

func load_actions():
	if saver.load_game("input_remap.tres") == null:
		print("did not load")
		return
	action_array.action_array = saver.load_game("input_remap.tres").action_array.duplicate()
	for i in action_array.action_array.size():
		var action_description = action_array.action_array[i]
		if action_description.events.size() > 0:
			InputMap.action_erase_events(action_description.action)
			for event in action_description.events:
				InputMap.action_add_event(action_description.action, event)
	print("did load")

# fade might look better
func _on_warning_timer_timeout() -> void:
	user_warning.hide()


# restore default
func _on_reset_button_pressed() -> void:
	InputMap.load_from_project_settings()
	create_action_list()
	save_actions()
