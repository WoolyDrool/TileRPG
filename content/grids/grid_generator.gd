@tool
class_name GridGenerator
extends Area3D

var tile_size = 4
@export var tile_scene : PackedScene

@onready var grid_volume : CollisionShape3D = $GridVolume
var grid_volume_size : Vector3

var grid_container : Node3D

@export_tool_button("Generate Grid") 
var generate_grid_action : Callable = try_generate_grid
var requested_size_x : int = 8
var requested_size_z : int = 8

var cur_gen_index_x : int = 0
var cur_gen_index_z : int = 0

var grid_gen_finished : bool = false

@export_tool_button("Reset Grid") 
var reset_grid_action : Callable = reset_grid

#TODO: Make it so it can generate "backwards"
#BUG: It seems to generate an extra column of tiles sometimes. Unsure of reason

#region Helpers
func is_req_size_valid() -> bool:
	grid_volume_size = grid_volume.shape.size
	
	requested_size_x = grid_volume_size.x as int
	requested_size_z = grid_volume_size.z as int
	
	# This determines wether or not the requested size divides evenly into tile_size 
	# tile_size should always be 4 but i made it a variable just in case things change later in development
	if requested_size_x % tile_size == 0 && requested_size_z % tile_size == 0:
		return true
	else:
		push_warning("GridGenerator: Request X or Y size is not divisible by tile_size!")
		return false

func try_generate_grid():
	if is_req_size_valid():
		begin_generate_grid()
	else:
		push_error("GridGenerator: Grid generation failed!")
#endregion

func begin_generate_grid():
	cur_gen_index_x = 0
	cur_gen_index_z = 0
	grid_gen_finished = false
	
	grid_container = Node3D.new()
	add_child(grid_container)
	grid_container.owner = get_tree().edited_scene_root
	grid_container.name = str(requested_size_x,"X",requested_size_z,"Z ", "Grid")
	
	print("GridGenerator: Beginning generation of a ", requested_size_x, "X, ", requested_size_z, "Z grid")
	
	generate_next_x_row()

func generate_next_x_row():
	# Create the new tile
	var new_tile : Node3D = tile_scene.instantiate()
	new_tile.position.y = position.y - tile_size
	new_tile.position.z = cur_gen_index_z
	
	if !check_finished():
		if !cur_x_grid_done():
			new_tile.position.x = -cur_gen_index_x
			cur_gen_index_x += tile_size 
			generate_next_x_row()
			new_tile.name = str("Tile ", "X",cur_gen_index_x, "Z", cur_gen_index_z)
			grid_container.add_child(new_tile)
			#add_child(new_tile)
			new_tile.owner = grid_container.get_tree().edited_scene_root
		else:
			print("GridGenerator: Finished current X row at ",cur_gen_index_x, ", Moving to next Z row")
			generate_next_z_row()
	else:
		if !grid_gen_finished:
			finish_generate_grid()

func cur_x_grid_done() -> bool:
	if cur_gen_index_x == requested_size_x:
		return true
	else:
		return false

func generate_next_z_row():	
	if !check_finished():
		if !cur_z_grid_done():
			cur_gen_index_x = 0
			cur_gen_index_z += tile_size
			generate_next_x_row()
	else:
		if !grid_gen_finished:
			finish_generate_grid()

func cur_z_grid_done() -> bool:
	if cur_gen_index_z == requested_size_z:
		return true
	else:
		return false

func check_finished() -> bool:
	if cur_gen_index_x == requested_size_x and cur_gen_index_z == requested_size_z:
		return true
	else:
		return false
	
func finish_generate_grid():
	pass
	
func reset_grid():
	grid_volume.shape.size = Vector3(tile_size, tile_size, tile_size)
	grid_volume.shape.transform.position = Vector3.ZERO
