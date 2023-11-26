extends Node2D
# TODO so long and thanks for all the fish


var item: Enum.ITEMS = 1

var moving: bool = true
#var direction: Enum.DIRECTION:
	#set(value):
		#direction = value
		#direction_change()

var vector_dir : Vector2 = Vector2(1, 0)

## defines speed for phyisic process
var speed: float = 60
var start_position: Vector2
var component: Node2D

## defines speed for tween
#var tween_time: float = 0.3

var current_direction: Enum.DIRECTION

const TWEEN_DISTANCE: float = 32


@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	sprite.frame_coords = Globals.get_item_frame_coords(item)
	set_physics_process(false)


func _physics_process(delta: float) -> void:
	#position += process_distance(current_direction) * (speed * delta)
	
	position = position.move_toward((start_position +tween_distance(current_direction)), delta * speed)
	
	if position == (start_position + tween_distance(current_direction)):
		set_physics_process(false)
		component.item_arrived(self)
	



func move(direction:int, next_component):
	start_position = position
	current_direction = direction
	component = next_component
	set_physics_process(true)
	
	
	## tween stuff
	#var tween: Tween = get_tree().create_tween()
	#var tween_vector = tween_distance(direction)
	#var start_position = position
	#tween.tween_property(self, "position", tween_vector + start_position, tween_time)
	#await tween.finished
	#next_component.item_arrived(self)
	

func tween_distance(direction: int):
	match direction:
		Enum.DIRECTION.N:
			return Vector2(0, -TWEEN_DISTANCE)
		Enum.DIRECTION.E:
			return Vector2(TWEEN_DISTANCE, 0)
		Enum.DIRECTION.S: 
			return Vector2(0, TWEEN_DISTANCE)
		Enum.DIRECTION.W:
			return Vector2(-TWEEN_DISTANCE, 0)
		_:
			printerr("invalid item direction")
			return Vector2(0,0)

#func process_distance(direction: int):
	#match direction:
		#Enum.DIRECTION.N:
			#return Vector2(0, -1)
		#Enum.DIRECTION.E:
			#return Vector2(1, 0)
		#Enum.DIRECTION.S: 
			#return Vector2(0, 1)
		#Enum.DIRECTION.W:
			#return Vector2(-1, 0)
		#_:
			#printerr("invalid item direction")
			#return Vector2(0,0)


#func direction_change():
	#match direction:
		#Enum.DIRECTION.N:
			#vector_dir = Vector2(0, -1)
		#Enum.DIRECTION.E:
			#vector_dir = Vector2(1, 0)
		#Enum.DIRECTION.S: 
			#vector_dir = Vector2(0, 1)
		#Enum.DIRECTION.W:
			#vector_dir = Vector2(0-1, 0)
		#_:
			#print("invalid item direction")
