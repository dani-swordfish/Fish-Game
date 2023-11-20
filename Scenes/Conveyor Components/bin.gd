extends Componenet
class_name Output

var item_node: Node2D = null

# has space for a new item.
var has_space: bool = true


func item_arrived():
	item_node.queue_free()
	has_space = true
