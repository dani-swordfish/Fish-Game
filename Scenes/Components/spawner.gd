extends Process

## stuff for item picker
@export var item: Enum.ITEMS
@export var item_picker_array: Array[Enum.ITEMS]
@onready var item_picker_ui: Control = %ItemPickerUI

@onready var item_sprite: Sprite2D = $ItemSprite

func _ready() -> void:
	#storage_limit = 1
	super._ready()
	


func _on_timer_timeout() -> void:
	if has_space == false: 
		process_timer.start()
		return
	
	item_node = spawn_item(item)
	has_item_ready = true
	process_timer.start()
	has_space = false


