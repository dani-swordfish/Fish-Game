extends Node2D


@onready var items: Node2D = $"../Items"
@onready var components: Node2D = $"../Components"
@onready var item_picker_ui: Control = %ItemPickerUI
@onready var sub_machine: Control = $"../SubMachine"
@onready var world_states: StateChart = $"../WorldStates"
@onready var level_root: Node2D = $".."
@onready var player_hand: Control = %PlayerHand
@onready var tilemap: TileMap = %Tilemap

# holds all the boxes
@onready var h_box_container: HBoxContainer = $"../UI/ComponentPicker/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/MarginContainer/HBoxContainer"

