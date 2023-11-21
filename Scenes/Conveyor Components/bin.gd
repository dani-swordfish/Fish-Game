extends Componenet
class_name Output

var item_node: Node2D = null

# has space for a new item.
var has_space: bool = true

func get_has_space(item_node_received)-> bool:
	return has_space

func item_arrived(arrived_item_node):
	item_node.queue_free()
	has_space = true
