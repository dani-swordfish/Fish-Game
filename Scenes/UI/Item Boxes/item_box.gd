extends Panel
class_name ItemBox

var item: Enum.ITEMS = 0


@onready var sprite: Sprite2D = $Sprite


func _ready() -> void:
	set_sprite()

func set_sprite():
	sprite.frame_coords = Globals.get_item_frame_coords(item)


