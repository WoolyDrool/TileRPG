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
@export var wall_in_ront : bool = false
@export var wall_in_back : bool = false

var current_rot_in_deg : float 

func _ready():
	rescan()

func rescan():
	#print("GridNav: RESCANNING...")
	if scanner_front.is_colliding() && tile_front != current_tile:
		tile_front = scanner_front.get_collider() as Tile
		#print("GridNav Front: ", tile_front)	
	
	if scanner_back.is_colliding():
		tile_behind = scanner_back.get_collider() as Tile	
		#print("GridNav Back: ", tile_behind)
		
	if wallcheck_front.is_colliding():
		wall_in_ront = true
	else:
		wall_in_ront = false
	
	if wallcheck_back.is_colliding():
		wall_in_back = true
	else:
		wall_in_back = false

func movement_tween(new_position : Vector3, parent : Node3D):
	if !parent:
		push_error("GridNav: " + name + "- No parent specified!")
		return
	if !new_position:
		return
		
	var movement_tween = create_tween()
	#print("GridNav: Moving to ", position)
	movement_tween.tween_property(parent, "position", new_position, tween_speed)
	moving = true

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
	
	rotation_tween.play()
	await rotation_tween.finished
	#print("GridNav: Finished rotation operation")
	rescan()
	moving = false
	rotation_tween = null 
	
func _on_tile_detector_area_entered(area: Area3D) -> void:
	if area.is_in_group("Tile"):
		previous_tile = current_tile
		current_tile = area
		if !current_tile:
			rescan()
