extends DialogueBase
class_name NPCDialogue
# Extend this script for actual npc

#@export var conversation_hello: Conversation
#@export var file_name_string: String # .txt file

@export var interaction_type: INTERACT_TRIGGER_TYPE = INTERACT_TRIGGER_TYPE.MANUAL
var current_convo: Conversation

var dialogue_converter: TextToConversationConverter = preload("res://Dialogue/Dialogue Components/TextToConversationConverter.tres")

func update_current_convo(): 
	pass
	
	## example stuff
##	current_convo = conversation_hello
#	current_convo = dialogue_converter.get_conversation_from_file(file_name_string)
#	
#	if player.has_carrot: # could make a seperate method for each of multiple converations
#		conversation_hello.dialogue_array[2].choices[0].next_index = 5
#	else:
#		conversation_hello.dialogue_array[2].choices[0].next_index = 3
	


func on_choice(conversation_index, choice_index):
	pass
	## example stuff
#	if current_convo == conversation_hello:
#		if conversation_index == 3:
#			if choice_index == 0:
#				player.has_carrot = false
