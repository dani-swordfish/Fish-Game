extends NPCDialogue

#@export var into_conversation: Conversation
@export var into_conversation: String
@export var was_saved_convo: Conversation

@export var character: WorldStates.CHARACTER

var was_saved: bool

@onready var converter: TextToConversationConverter = preload("res://Dialogue/Dialogue Components/TextToConversationConverter.tres")

@onready var harvest: Control = %Harvest
@onready var lanterns: Node2D = $"../../../Lanterns"


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var npcs: Node2D = $"../.."




func update_current_convo(): 
	
	if was_saved:
		current_convo = was_saved_convo
		
	else:
		current_convo = converter.get_conversation_from_file(into_conversation)
		get_parent().ghost_intro.play()


func on_choice(conversation_index, choice_index):
	
	if conversation_index == 3: 
		if choice_index == 0:
			harvest.open(get_parent())
			collision_shape_2d.set_deferred("disabled" , true)
			
		elif choice_index == 1:
			WorldStates.character_has_been_saved = true
			WorldStates.saved_character = character
			was_saved = true
			$"../../../Sound/SavedSound".play()
			npcs._on_saved_or_harvested()
			pass # saved anim and sound
			


func extinguish_lantern():
	for lantern in lanterns.get_children():
			if lantern.character == character:
				lantern.extinguish()

