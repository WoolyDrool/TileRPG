class_name Player
extends Area3D

@export var navigator : GridNavigator
@export var combat_manager : GridCombatManager
var moving : bool = false
var turning : bool = false
var movement_length : int = 4
var turning_deg : float = 90
var facing_dir : float 
@export var tween_speed : float = 1
@export var turn_speed : float = 1
@export var cam_container : Node3D

@onready var movement_cooldown_timer : Timer = $MovementCooldownTimer
var can_move = true

var turn_deg = 90

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	facing_dir = self.rotation.y
	if facing_dir > 360:
		facing_dir -= 360
	handle_movement_input()

#region Movement
func handle_movement_input() -> void:
	if can_move:
		if !navigator.moving:
			if Input.is_action_just_pressed("move_forward") && !navigator.wall_in_ront:
				if !navigator.tile_front:
					navigator.rescan()
				navigator.movement_tween(navigator.tile_front.center, self)
				start_movement_cooldown()
			if Input.is_action_just_pressed("move_backward") && !navigator.wall_in_back:
				if !navigator.tile_behind:
					navigator.rescan()
				navigator.movement_tween(navigator.tile_behind.center, self)
				start_movement_cooldown()
			
		if !turning:
			if Input.is_action_just_pressed("turn_left"):
				navigator.rotation_tween(turn_deg, cam_container)
				start_movement_cooldown()
			if Input.is_action_just_pressed("turn_right"):
				navigator.rotation_tween(-turn_deg, cam_container)
				start_movement_cooldown()

func start_movement_cooldown():
	can_move = false
	movement_cooldown_timer.start()
#func handle_camera_turning(leftright : bool):
	#pass
	#turning = true
	#if !leftright:
		#var turn_rotation = Vector3(0, cam_container.rotation.y + deg_to_rad(turning_deg), 0)
		#var turn_quat = Quaternion.from_euler(turn_rotation)
		#await get_tree().create_tween().tween_property(cam_container, "quaternion", turn_quat, turn_speed)
	#else:
		#var turn_rotation = Vector3(0, cam_container.rotation.y - deg_to_rad(turning_deg), 0)
		#var turn_quat = Quaternion.from_euler(turn_rotation)
		#await get_tree().create_tween().tween_property(cam_container, "quaternion", turn_quat, turn_speed)
		#turning = false

func _on_movement_cooldown_timer_timeout() -> void:
	can_move = true
	combat_manager.rescan_for_targets()
	Globals.time_advance_tick.emit()
	pass # Replace with function body.
#endregion
		
func _on_tile_enter(area: Area3D) -> void:
	if area.is_in_group("Tile"):
		navigator.current_tile = area as Tile

func _on_tile_exit(area: Area3D) -> void:
	if area.is_in_group("Tile"):
		navigator.current_tile = null
