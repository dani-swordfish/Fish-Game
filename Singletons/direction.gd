extends Node
class_name Enum

enum DIRECTION {
	N,
	E,
	S,
	W,
}

enum COMPONENTS {
	EMPTY,
	CONV_STRAIT,
	CONV_CORNER,
	CONV_SPLITTER,
	CONV_SORTER,
	CONV_BRIDGE,
	SPAWNER,	
	CUTTER,
	CONSTRUCTOR,
	BIN,
	OUTPUT,
	RANDI_CUTTER,
	REMOVE_COMPONENT, # used by player hand and submachine, not actually a component
}

enum ITEMS {
	NONE,
	SALMON,
	SALMON_SCALE,
	SALMON_MEAT,
	RICE,
	SEAWEED,
	SALMON_SUSHI,
	
	ANGLER,
	ANGLER_SCALE,
	LIGHT_BULB,
	
	SNAKE,
	SNAKE_SCALE,
	SNAKE_MEAT,
	SNAKE_SKEWER,
	GOLD,
	GOLD_BUCKLE,
	SNAKE_BELT,
	
	CLOWN_FISH,
	CLOWN_FISH_SCALE,
	CLOWN_FISH_SUSHI,
	GLASS,
	FISH_BOWL,
	CLOWN_FISH_BOWL,
	
	MALTI_SCALE,
	
}

