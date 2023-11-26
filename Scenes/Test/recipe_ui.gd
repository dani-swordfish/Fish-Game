extends Control

var is_open: bool = false

@onready var world_states: StateChart = $"../../WorldStates"
@onready var texture_button: TextureButton = $"../TextureButton"
@onready var texture_rect: TextureRect = $"../TextureButton/TextureRect"

@onready var constructor_recipes: PanelContainer = $VBoxContainer/ConstructorRecipes
@onready var cutter_recipes: PanelContainer = $VBoxContainer/CutterRecipes


func _ready() -> void:
	close()
	constructor_recipes.show()
	cutter_recipes.hide()


func open():
	is_open = true
	texture_rect.texture.region = Rect2(0,0,32,32)
	show()
	


func close():
	is_open = false
	texture_rect.texture.region = Rect2(32,0,32,32)
	hide()


func _on_texture_button_pressed() -> void:
	if world_states.get_child(0)._active_state.name == "Play": 
		return
	
	if is_open:
		close()
	else:
		open()


func _on_contructor_button_toggled(toggled_on: bool) -> void:
	constructor_recipes.show()
	cutter_recipes.hide()


func _on_cutter_button_toggled(toggled_on: bool) -> void:
	constructor_recipes.hide()
	cutter_recipes.show()
