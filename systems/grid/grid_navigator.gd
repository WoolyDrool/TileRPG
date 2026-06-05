class_name GridNavigator
extends Node3D

@export var current_tile : Tile
@export var previous_tile : Tile
@export var tween_speed : float = 1
@export var moving : bool = false
@export var tile_front : Tile
@export var tile_behind : Tile

@onready var scanner_front : RayCast3D = $ScannerBody/ScannerFront	
@onready var scanner_back : RayCast3D = $ScannerBody/ScannerBack
@onready var scanner_body : Node3D = $ScannerBody

@export var wallcheck_front : RayCast3D
@export var wallcheck_back : RayCast3D
@export var wall_in_front : bool = false
@export var wall_in_back : bool = false

@export var foostep_sfx : AudioStreamPlayer3D
@export var turn_sfx : AudioStreamPlayer3D

var current_rot_in_deg : float 

func _ready():
	pass

func rescan():
	#print("GridNav: RESCANNING...")
	check_for_tiles()
	check_for_walls()
	
	#DEBUG ONLY
	#print("Current Tile: ", current_tile)
	#print("Previous Tile: ", previous_tile)
	#print("Tile Front: ", tile_front)
	#print("Tile Back: ", tile_behind)
	#print("Wall Front: ", wall_in_front)
	#print("Wall Back: ", wall_in_back)

func check_for_tiles():
	if scanner_front.is_colliding():
		var col_result = scanner_front.get_collider()
		if col_result.is_in_group("Tile") && col_result != current_tile:
			tile_front = scanner_front.get_collider()

		col_result = null
		#print("GridNav Front: ", tile_front)	
	
	if scanner_back.is_colliding():
		var col_result = scanner_back.get_collider()
		if col_result.is_in_group("Tile") && col_result != current_tile:
			tile_behind = scanner_back.get_collider()
		
		col_result = null
		#print("GridNav Back: ", tile_behind)

func check_for_walls():
	if wallcheck_front.is_colliding():
		wall_in_front = true
	else:
		wall_in_front = false
	
	if wallcheck_back.is_colliding():
		wall_in_back = true
	else:
		wall_in_back = false

func movement_tween(new_position : Vector3, parent : Node3D):
	#NOTE: I have to rewrite this to be a custom Vector3 Lerp solution because
	# it appears that Tweens do not like moving to 0,0,0
	# its an edge case but also so specific that i feel compelled to fix it
	
	if !parent:
		push_error("GridNav: " + name + "- No parent specified!")
		return
	if !new_position:
		return
	
	var movement_tween = create_tween()
	#print("GridNav: Moving to ", position)
	movement_tween.tween_property(parent, "position", new_position, tween_speed)
	moving = true
	foostep_sfx.play()
	
	movement_tween.play()
	await movement_tween.finished
	#print("GridNav: Finished movement operation")
	rescan()
	moving = false
	movement_tween = null

func rotation_tween(new_rotation : float, parent : Node3D):
	if !parent:
		push_error("GridNav: " + name + "- No parent specified!")
		return
	if !new_rotation:
		return

	var rotation_tween = create_tween()
	
	var turn_rotation
	var turn_quat
	moving = true
	turn_rotation = Vector3(0, parent.rotation.y + deg_to_rad(new_rotation), 0)
	turn_quat = Quaternion.from_euler(turn_rotation)
	rotation_tween.tween_property(parent, "quaternion", turn_quat, tween_speed)
	turn_sfx.play()
	
	rotation_tween.play()
	await rotation_tween.finished
	#print("GridNav: Finished rotation operation")
	rescan()
	moving = false
	rotation_tween = null 

func enter_new_tile(tile : Tile):
	current_tile = tile
