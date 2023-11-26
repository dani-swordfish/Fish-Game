extends PanelContainer


const RECIPE: PackedScene = preload("res://Scenes/UI/recipe.tscn")

@onready var recipe_ui: Control = $"../.."
@onready var recipe_container: VBoxContainer = %RecipeContainer
@onready var close_button: Button = %CloseButton
@onready var label: Label = $MarginContainer/RecipeContainer/Label


func _ready() -> void:
	spawn_recipes()
	move_close_button()


func spawn_recipes():
	if is_in_group("constructor_recipes"):
		label.text = "Contructor Recipes"
		for item: int in Globals.references.level_root.options.constructor_recipes:
			spawn_recipe(item, Enum.COMPONENTS.CONSTRUCTOR)
	
	if is_in_group("cutter_recipes"):
		label.text = "Cutter Recipes"
		for item :int in Globals.references.level_root.options.cutter_recipies:
			spawn_recipe(item, Enum.COMPONENTS.CUTTER)


func spawn_recipe(item: int, type: int):
	var recipe_inst = RECIPE.instantiate()
	recipe_inst.type = type
	recipe_inst.item = item
	recipe_container.add_child(recipe_inst)
	

func move_close_button():
	recipe_container.move_child(close_button, -1)
	

func _on_close_button_pressed() -> void:
	recipe_ui.close()



