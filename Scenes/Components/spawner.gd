extends Process

## stuff for item picker
# TODO turn into resource
@export var item: Enum.ITEMS
@export var item_picker_array: Array[Enum.ITEMS]
@export var player_can_pick: bool = true
@export var override_level_default: bool = false
@onready var item_picker_ui: Control = Globals.references.item_picker_ui

# TODO use to give spawner different rates in different levels
# also add to randi spawner
@export var spawn_rate: float = 1.0


func _ready() -> void:
	#storage_limit = 1
	super._ready()
	process_timer.wait_time = spawn_rate


func _on_play():
	super._on_play()
	process_timer.start()


func _on_timer_timeout() -> void:
	if has_space == false: 
		process_timer.start()
		return
	
	item_node = spawn_item(item)
	has_item_ready = true
	process_timer.start()
	has_space = false


