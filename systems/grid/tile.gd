class_name Tile
extends Area3D

@export var center : Vector3
var current_in_tile_navigator : GridNavigator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = get_center_point()
		
func get_center_point() -> Vector3:
	return global_position


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player"):
		current_in_tile_navigator = area.navigator
		if current_in_tile_navigator:
			current_in_tile_navigator.enter_new_tile(self)

func _on_area_exited(area: Area3D) -> void:
	pass
