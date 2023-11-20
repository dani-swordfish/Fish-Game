extends Control
# TODO handle none as speaker, remove spacing so it looks right


var is_open: bool
var current_convo: Conversation = null
var conversation_index: int = 0
var npc = null

# for resizing text box correctly, could tween it to make it smooth
# not being used remove
var nine_patch_rect_minimum_size: int = 48
var nine_patch_rect_space_from_bottom: int = 12
var spacer: int = nine_patch_rect_minimum_size + nine_patch_rect_space_from_bottom

# For displaying text one letter at a time
var letter_time: float = 0.03
var space_time: float = 0.06
var punctuation_time: float = 0.02
var letter_index: int = 0
@onready var letter_display_timer: Timer = $LetterDisplayTimer


@onready var speaker: RichTextLabel = $MarginContainer2/NinePatchRect/Speaker
@onready var dialogue: RichTextLabel = $MarginContainer2/NinePatchRect/MarginContainer/VBoxContainer/Dialogue
@onready var progress_once: TextureButton = $ProgressOnce


@onready var nine_patch_rect: NinePatchRect = $MarginContainer2/NinePatchRect
@onready var margin_container: MarginContainer = $MarginContainer2/NinePatchRect/MarginContainer
@onready var v_box_container: VBoxContainer = $MarginContainer2/NinePatchRect/MarginContainer/VBoxContainer
@onready var choice_scene = preload("res://Dialogue/choice_scene.tscn")

@onready var page_turn: AudioStreamPlayer = $PageTurn

func _ready() -> void:
	hide()

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("dialogue_skip"):
		_on_progress_once_pressed()
	
	

func open(_npc): 
	get_tree().paused = true
	is_open = true
	npc = _npc
	npc.update_current_convo()
	if npc.current_convo == null:
		printerr("npc has no current dialogue, closing dialogue manager")
		close()
		return
	current_convo = npc.current_convo
	conversation_index = 0 # might take index from npc to start in the middle of a conversation
	show()
	diplay_dialogue_or_close()


func close():
	get_tree().paused = false
	is_open = false
	current_convo = null
	conversation_index = 0
	npc = null
	hide()


func _on_progress_once_pressed() -> void:
	if current_convo == null:
		close()
		return
	if current_convo.dialogue_array[conversation_index].has_signal("DialogueScriptEnd"):
		close()
		return
	
	if current_convo.dialogue_array[conversation_index].has_signal("DialogueScriptChangeIndex"):
		conversation_index = current_convo.dialogue_array[conversation_index].next_index
	else:
		conversation_index += 1
	page_turn.play()
	diplay_dialogue_or_close()
	

func _on_choice_chosen(choice_index: int):
	if npc.has_method("on_choice"): # has to be first so NPC can override choice index
			npc.on_choice(conversation_index, choice_index)
	conversation_index = current_convo.dialogue_array[conversation_index].choices[choice_index].next_index
	page_turn.play()
	diplay_dialogue_or_close()



# could add an option to autumatically start a new conversation on index == -2 or DialogueScriptStartNewConvo
func diplay_dialogue_or_close(): 
	speaker.text = ""
	dialogue.text = ""
	letter_index = 0
	#reset_textbox_to_minimum_size()
	
	if conversation_index >= current_convo.dialogue_array.size() \
	or conversation_index == -1:
		close()
		return
	
	# prevents skipping dialogue
	progress_once.hide()
	
	
	speaker.text = current_convo.dialogue_array[conversation_index].speaker
	if speaker.text == "none":
		speaker.hide()
	else:
		speaker.show()
	
	
	for child in v_box_container.get_children():
			if child.is_in_group("choice"):
				child.queue_free()
	
	
	# this sets up the new dialogue based on it's type
	if current_convo.dialogue_array[conversation_index].has_signal("DialogueScriptMultiChoice"):
		var loop = 0
		for choice in current_convo.dialogue_array[conversation_index].choices:
			var choice_inst = choice_scene.instantiate()
			choice_inst.text = choice.choice_text
			choice_inst.choice_index = loop
			v_box_container.add_child(choice_inst)
			choice_inst.choice_chosen.connect(_on_choice_chosen)
			loop +=1
		loop = 0
	
	#streach_textbox_to_fit()
	display_letter()


func display_letter():  # is called on letter display timer timeout
	
	# caused by player closing the dialogue box before all the letter have been typed, 
	# should not need error message
	if current_convo == null:
		close()
		return
	if current_convo.dialogue_array[conversation_index].sentence == "":
		close()
		printerr("no sentance entered for dialogue, closing dialogue handler")
		return
	dialogue.text += current_convo.dialogue_array[conversation_index].sentence[letter_index]
	letter_index += 1
	
	if letter_index >= current_convo.dialogue_array[conversation_index].sentence.length():
		on_finished_displaying() #could impement to effect next button push behavour or visiblity
		return
		
	match current_convo.dialogue_array[conversation_index].sentence[letter_index]:
		",",".","!","?":
			letter_display_timer.start(punctuation_time)
		" ":
			letter_display_timer.start(space_time)
		_:
			letter_display_timer.start(letter_time)
	

func _on_letter_display_timer_timeout() -> void:
	display_letter()
	#streach_textbox_to_fit()


# TODO rewrite / learn Godot UI
# this and function below not being used
func streach_textbox_to_fit():
	nine_patch_rect.size.y = margin_container.size.y
	nine_patch_rect.position.y = (spacer - nine_patch_rect.size.y)


func reset_textbox_to_minimum_size():
	nine_patch_rect.size.y = nine_patch_rect_minimum_size
	nine_patch_rect.position.y = nine_patch_rect_space_from_bottom


func on_finished_displaying() -> void:
	# prevents skipping dialogue
	if !current_convo.dialogue_array[conversation_index].has_signal("DialogueScriptMultiChoice"):
		progress_once.show()
