extends Node2D

@export var into_cutscene: Conversation


#var intro_test = 
var choice_test = "res://Dialogue/Dialogue Text/choice_test_notepad.txt"
var intro_text = "res://Dialogue/Dialogue Text/dialogue_test.txt"

var has_played_intro: bool
var current_convo: Conversation

@onready var dialogue_handler: Control = %DialogueHandler
@onready var converter: TextToConversationConverter = preload("res://Dialogue/Dialogue Components/TextToConversationConverter.tres")

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	dialogue_handler.open(self) #  enable before export
	#label.text = node.load_file(intro_test)


func update_current_convo(): 
	if !has_played_intro:
		current_convo = converter.get_conversation_from_file(intro_text)
