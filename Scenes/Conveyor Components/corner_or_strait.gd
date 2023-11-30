extends Conveyor


#@onready var conveyor_sprite: Sprite2D = $ConveyorSprite
@onready var conveyor_animation: AnimatedSprite2D = $ConveyorAnimation


var corner: bool:
	set(value):
		corner = value
		if corner:
			conveyor_animation.animation = "corner"
		else:
			conveyor_animation.animation = "strait"


var flipped: bool:
	set(value):
		flipped = value
		if flipped:
			conveyor_animation.flip_v = true
		else:
			conveyor_animation.flip_v = false
			
			
			#if direction == 0 or direction == 2:
				#conveyor_animation.flip_v = false
			#else:
				#conveyor_animation.flip_v = true
		#else:
			#if direction == 0 or direction == 2:
				#conveyor_animation.flip_v = true
			#else:
				#conveyor_animation.flip_v = false
	



var inputs: Array[Enum.DIRECTION] = []


func connection_made(_direction):
	inputs.append(get_local_direction(_direction))

func before_components_changed():
	inputs = []

func after_components_changed():
	ajust_for_inputs()


func ajust_for_inputs():
	inputs.sort()
	
	inputs.erase(0)
	
	if inputs.size() == 0:
		corner = false
		flipped = false
	
	if inputs.size() == 1:
		match inputs[0]:
			1:
				corner = true
				flipped = false
			2:
				corner = false
				flipped = false
			3:
				corner = true
				flipped = true
	
	if inputs.size() == 2:
		if inputs == [1,3]:
			conveyor_animation.animation = "up_and_down_inputs"
		
		else:
			conveyor_animation.animation = "left_and_other_inputs"
			if  inputs == [1,2]:
				flipped = false
			if inputs == [2,3]:
				flipped = true
	
	if inputs.size() == 3:
		conveyor_animation.animation = "three_inputs"
		
	





func get_local_direction(start_direction):
	start_direction -= (direction - 2)
	start_direction = Globals.get_fixed_direction(start_direction)
	
	return start_direction



func _ready() -> void:
	super._ready()
	if corner:
		$ConveyorAnimation.animation = "corner"
	else:
		$ConveyorAnimation.animation = "strait"


#func _on_play():
	#super._on_play()
	#
#
#func _on_stop():
	#super._on_stop()
	#

