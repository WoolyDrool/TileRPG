class_name MapTransitionPoint
extends Node3D

@export var next_map : Map

#NOTE: I'd like to find a better way to do this than strings but idk it might be good enough
@export var trans_point_name : String = "Default Point Name Value"
@export var exit_trans_point_name : String = "Default Exit Point Name Value"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
