extends Output

@export var item: Enum.ITEMS


# TODO pass to UI
var item_count: int
@onready var label: Label = $Label

func item_arrived(arrived_item_node):
	if item_node.item == item:
		item_count += 1
		label.text = str(item_count)
	else:
		print("wrong item in output")
		pass # could add gameplay outcome
	super.item_arrived(arrived_item_node)
