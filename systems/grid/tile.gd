class_name Tile
extends Area3D

@export var center : Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = get_center_point()
		
func get_center_point() -> Vector3:
	return global_position
