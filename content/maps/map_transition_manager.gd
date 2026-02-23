class_name MapTransitionManager
extends Node3D

@export var current_map : Map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.map_transition.connect(transition_map)


func transition_map(new_map : Map, trans_point : MapTransitionPoint):
	if new_map == current_map:
		push_warning("MapTransitionManager: Map transition failed")
		push_error("MapTransitionManager: new_map is the same as current_map!")
		return
	
	current_map.on_map_exit()
	current_map = new_map
	current_map.on_map_enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
