class_name TileStair
extends Tile

@export var custom_y_value : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = get_stair_center()
		
func get_stair_center() -> Vector3:
	return Vector3(position.x, custom_y_value, position.z)
