extends MenuHub

var is_open:bool


func _ready() -> void:
	close()
	super._ready()


func _input(event: InputEvent) -> void:
	## can add return option if game state should prevent opening menu
	#if inventory.is_open: return
	
	if event.is_action_pressed("pause_menu"):
		if is_open:
			close()
		else:
			open()


func open():
	is_open = true
	super.open()


func close():
	is_open = false
	super.close()
