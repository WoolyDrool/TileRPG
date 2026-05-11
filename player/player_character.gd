class_name Player
extends Area3D

@export_category("Input")
@export var move_forward_action : GUIDEAction
@export var move_backward_action : GUIDEAction
@export var turn_left_action : GUIDEAction
@export var turn_right_action : GUIDEAction

@export_category("Controller Settings")
@export var tween_speed : float = 1
@export var turn_speed : float = 1

@onready var navigator : GridNavigator = $CamContainer/GridNavigator
@onready var cam_container : Node3D = $CamContainer
@onready var movement_cooldown_timer : Timer = $MovementCooldownTimer

var can_move = true
var moving : bool = false
var turning : bool = false
var movement_length : int = 4
var turning_deg : float = 90
var facing_dir : float 
var turn_deg = 90

func _ready() -> void:
	Globals.player_seize_controls.connect(seize_controls)
	Globals.player_return_controls.connect(return_controls)
	return_controls()

func seize_controls():
	can_move = false

func return_controls():
	can_move = true
	
func _process(delta: float) -> void:
	facing_dir = self.rotation.y
	if facing_dir > 360:
		facing_dir -= 360
	handle_movement_input()

#region Movement
func handle_movement_input() -> void:
	if can_move:
		if !navigator.moving:
			if move_forward_action.is_triggered() && !navigator.wall_in_ront:
				if !navigator.tile_front:
					navigator.rescan()
				navigator.movement_tween(navigator.tile_front.center, self)
				start_movement_cooldown()
			if move_backward_action.is_triggered() && !navigator.wall_in_back:
				if !navigator.tile_behind:
					navigator.rescan()
				navigator.movement_tween(navigator.tile_behind.center, self)
				start_movement_cooldown()
			
		if !turning:
			if turn_left_action.is_triggered():
				navigator.rotation_tween(turn_deg, cam_container)
				start_movement_cooldown()
			if turn_right_action.is_triggered():
				navigator.rotation_tween(-turn_deg, cam_container)
				start_movement_cooldown()

func start_movement_cooldown():
	can_move = false
	movement_cooldown_timer.start()
	
func _on_movement_cooldown_timer_timeout() -> void:
	can_move = true
	Globals.time_advance_tick.emit()
	pass # Replace with function body.
#endregion
		
func _on_tile_enter(area: Area3D) -> void:
	if area.is_in_group("Tile"):
		navigator.current_tile = area as Tile

func _on_tile_exit(area: Area3D) -> void:
	if area.is_in_group("Tile"):
		navigator.current_tile = null
