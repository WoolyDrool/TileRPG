class_name TileStair
extends Tile

@export var custom_y_value : float
@export var is_bottom_stair : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center = get_stair_center()
		
func get_stair_center() -> Vector3:
	if !is_bottom_stair:
		return Vector3(global_position.x, custom_y_value, global_position.z)
	else:
		return Vector3(global_position.x, custom_y_value - 0.001, global_position.z)

func _on_area_entered(area: Area3D) -> void:
	super(area)
