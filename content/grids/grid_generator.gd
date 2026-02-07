@tool
class_name GridGenerator
extends Area3D

var tile_size = 4
var tile_path = NodePath("res://content/grids/tile.tscn")
@onready var grid_volume : CollisionShape3D = $GridVolume

#TODO: Constrain the volume to multiples of tile_size (tiles are 4x4)
#TODO: Define the width and length of the volume to an array
#TODO: Generate tiles recursively until finished
#TODO: Add a button in the inspector to make easier

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
