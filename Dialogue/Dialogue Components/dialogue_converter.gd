extends Resource
class_name TextToConversationConverter
## this is a resource which takes in txt files as arguments and create conversations


## start of speaker name
const format_speaker_start: String = "@"

## end of speaker name, also removes extra lines
const format_speaker_end: String = "
"

## start of choice text
const format_choice_start: String = "+"

## seperate string from index, string is choice for choice script and sentance for change index
const format_string_index: String = ":"



func get_conversation_from_file(file) -> Conversation:
	# string with everying from the text file
	var text_string: String = load_file(file)
	
	
	# string with everying from the text file split into parts
	var spilt_file_array: PackedStringArray = text_string.split(format_speaker_start, false)
	
	
	var dialogue_script_array: Array[DialogueScript]
	
	for i in spilt_file_array.size():
		var dialogue_script
		
		# string with everything for one dialogue script
		var script = spilt_file_array[i]
		# string with everything for one dialogue script split into parts
		var split_script = script.split(format_speaker_end, false, 1)
		var speaker = split_script[0]
		if split_script[1].contains(format_choice_start):
			dialogue_script = create_dialogue_script_multi_choice(speaker, split_script[1])
		elif split_script[1].contains(format_string_index):
			dialogue_script = create_dialogue_script_change_index(speaker, split_script[1])
		else:
			dialogue_script = create_dialogue_script(speaker, split_script[1])
		
		dialogue_script_array.append(dialogue_script)
	
	var new_conversation = create_conversation(dialogue_script_array)
	return new_conversation

func load_file(file_to_load) -> String:
	var file2 = FileAccess.open(file_to_load, FileAccess.READ)
	var content: String = file2.get_as_text()
	return content
	

func create_dialogue_script(speaker: String, sentance: String) -> DialogueScript:
	var new_script: DialogueScript = DialogueScript.new()
	new_script.sentence = sentance
	new_script.speaker = speaker
	return new_script


func create_dialogue_script_multi_choice(speaker: String, sentance_and_choices: String) -> DialogueScriptMultiChoice:
	var new_script: DialogueScriptMultiChoice = DialogueScriptMultiChoice.new()
	new_script.speaker = speaker
	var sentance_and_choices_split = sentance_and_choices.split(format_choice_start, false)
	new_script.sentence = sentance_and_choices_split[0]
	for i in range(1 , sentance_and_choices_split.size()): # [0] is sentance
		var new_choice = create_choice(sentance_and_choices_split[i])
		new_script.choices.append(new_choice)
	return new_script


func create_choice(choice_text_and_next_index) -> Choice:
	var choice_text_and_next_index_split = choice_text_and_next_index.split(format_string_index, false)
	var new_choice: Choice = Choice.new()
	new_choice.choice_text = choice_text_and_next_index_split[0]
	new_choice.next_index = int(choice_text_and_next_index_split[1])
#	print(choice_text_and_next_index_split)
	return new_choice


func create_dialogue_script_change_index(speaker: String, sentance_and_index: String) -> DialogueScriptChangeIndex:
	var new_script = DialogueScriptChangeIndex.new()
	var sentance_and_next_index_split = sentance_and_index.split(format_string_index, false)
	new_script.speaker = speaker
	new_script.sentence = sentance_and_next_index_split[0]
	new_script.next_index = int(sentance_and_next_index_split[1])
	return new_script


func create_conversation(script_array: Array[DialogueScript]) -> Conversation:
	var new_conversation = Conversation.new()
	new_conversation.dialogue_array = script_array
	return new_conversation
