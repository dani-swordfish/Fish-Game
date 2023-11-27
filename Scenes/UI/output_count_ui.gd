extends HBoxContainer

var item: Enum.ITEMS
var item_count_target: int

@onready var item_box: ItemBox = $ItemBox
@onready var current_label: Label = $CurrentLabel
@onready var target_label: Label = $TargetLabel


func _ready() -> void:
	item_box.item = item
	target_label.text = str(item_count_target)

func set_current_item(current_item):
	current_label.text = str(current_item)

