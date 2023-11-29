extends PanelContainer


var item: int

var recipe: Array[Array]
var type: int


const LABEL_FOR_RECIPE = preload("res://Scenes/UI/label_for_recipe.tscn")
const ITEM_BOX: PackedScene = preload("res://Scenes/UI/Item Boxes/item_box.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer

func _ready() -> void:
	if type == Enum.COMPONENTS.CONSTRUCTOR:
		spawn_contructor_recipe()
	else:
		spawn_cutter_recipe()


func spawn_contructor_recipe():
	recipe = Globals.get_constuctor_recipe(item)
	spwan_spacer()
	# j is items and amont index, i is amount index
	for j in recipe.size():
		for i in recipe[j][1]:
			spawn_item_box(recipe[j][0])
			
			# prevents spwaning a plus on the last loop
			if (j + 1) == recipe.size() and (i + 1) == recipe[j][1]:
				pass
			else:
				spawn_label(true)
	spwan_spacer()
	spawn_label(false)
	spawn_item_box(item)


func spawn_cutter_recipe():
	recipe = Globals.get_cutter_recipe(item)
	spawn_item_box(item)
	spawn_label(false)
	
	spwan_spacer()
	for j in recipe.size():
		for i in recipe[j][1]:
			spawn_item_box(recipe[j][0])
			
			# prevents spwaning a plus on the last loop
			if (j + 1) == recipe.size() and (i + 1) == recipe[j][1]:
				pass
			else:
				spawn_label(true)
	
	spwan_spacer()


func spawn_item_box(item_to_spawn):
	var item_inst = ITEM_BOX.instantiate()
	item_inst.item = item_to_spawn
	h_box_container.add_child(item_inst)


func spawn_label(is_plus:bool):
	var label_inst = LABEL_FOR_RECIPE.instantiate()
	if is_plus:
		label_inst.text = "+"
	else:
		label_inst.text = "= "
	h_box_container.add_child(label_inst)

func spwan_spacer():
	var spacer = Control.new()
	spacer.size_flags_horizontal = spacer.SIZE_EXPAND
	h_box_container.add_child(spacer)




