@tool
class_name GridGenerator
extends Area3D

var tile_size = 4
@export var tile_scene : PackedScene


@export_tool_button("Generate Grid") 
var generate_grid_action : Callable = try_generate_grid

@export_tool_button("Reset Grid") 
var reset_grid_action : Callable = reset_grid

@onready var grid_volume : CollisionShape3D = $GridVolume
var grid_volume_size : Vector3
var requested_size_x : int = 8
var requested_size_z : int = 8

var cur_gen_index_z : int = 0
var cur_gen_index_x : int = 0


#TODO: Define the width and length of the volume to an array
#TODO: Generate tiles recursively until finished

func reset_grid():
	grid_volume.shape.size = Vector3(tile_size, tile_size, tile_size)
	grid_volume.shape.position = position
	for child in get_children():
		child.queue_free()

func is_req_size_valid() -> bool:
	var grid_volume_size : Vector3 = grid_volume.shape.size
	
	requested_size_x = grid_volume_size.x
	requested_size_z = grid_volume_size.y
	
	if requested_size_x % tile_size == 0 && requested_size_z % tile_size == 0:
		return true
	else:
		push_warning("GridGenerator: Request X or Y size is not divisible by tile_size!")
		return false

func try_generate_grid():
	if is_req_size_valid():
		generate_grid()
	else:
		push_error("GridGenerator: Grid generation failed!")

func generate_grid():
	cur_gen_index_x = 0
	cur_gen_index_z = 0
	
	generate_next_x_row()
	
	print("GridGenerator: Generated a grid successfully")

func generate_next_x_row():
	# Create the new tile
	var new_tile : Node3D = tile_scene.instantiate()
	new_tile.position.y = position.y - tile_size
	new_tile.position.z = cur_gen_index_z
	
	if !cur_x_grid_done():
		new_tile.position.x = -cur_gen_index_x
		add_child(new_tile)
		new_tile.owner = get_tree().edited_scene_root
		cur_gen_index_x += tile_size 
		generate_next_x_row()
	else:
		print("GridGenerator: Finished current X row. Moving to next Z row")
		generate_next_z_row()

func generate_next_z_row():		
	if !cur_z_grid_done():
		cur_gen_index_x = 0
		cur_gen_index_z += tile_size
		generate_next_x_row()

func cur_x_grid_done() -> bool:
	if cur_gen_index_x == requested_size_x:
		return true
	else:
		return false

func cur_z_grid_done() -> bool:
	if cur_gen_index_z == requested_size_z:
		return true
	else:
		return false


	
	
