extends DialogueBase
# could use enum for interact type

@onready var dialogue_handler = %DialogueHandler
@onready var harvest: Control = %Harvest # for this game only


func _ready() -> void:
	pass
	## for triggering on entered
	area_entered.connect(on_area_entered)
	


func on_area_entered(area: Area2D):
	pass
	## for triggering on entered
	if !area.is_in_group("npc_dialogue"): return
	if !area.interaction_type == INTERACT_TRIGGER_TYPE.AUTOMATIC: return
	
	var npc = area
	dialogue_handler.open(npc)

## for triggering on interact
func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		for area in get_overlapping_areas():
			if area.is_in_group("npc_dialogue"):
				var npc = area
				dialogue_handler.open(npc)
