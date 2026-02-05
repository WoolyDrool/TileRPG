class_name Tile
extends Area3D

@export var center : Vector3

signal on_tile_enter
signal on_tile_exit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = get_center_point()

func get_center_point() -> Vector3:
	return self.global_position

func enter_tile():
	pass

func exit_tile():
	pass
