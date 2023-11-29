extends Resource
class_name Saver

## save game stuff

const SAVE_FILE_PATH = "user://game_save/"
#const SAVE_FILE_NAME = "player_save.tres"


func save_game(save_data: Resource, save_file_name: String):
	verify_save_directory(SAVE_FILE_PATH)
	var save_file = ResourceSaver.save(save_data, SAVE_FILE_PATH + save_file_name)
	
	if save_data is HighScore:
		print(save_data.levels_array)
	
	if save_file == null:
		printerr("ERROR CREATING SAVE FILE ", FileAccess.get_open_error())
		return

# creates a save folder if there is not one.
# can be run on ready
func verify_save_directory(path: String):
	DirAccess.make_dir_absolute(path)
	

func load_game(save_file_name: String) -> Resource:
	if !FileAccess.file_exists(SAVE_FILE_PATH + save_file_name):
		printerr("save file not found")
		return null
	var save_data = ResourceLoader.load(SAVE_FILE_PATH + save_file_name)#.duplicate(true)
	return save_data
