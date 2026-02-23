class_name Map
extends Node3D

@export var map_name : String = "Default Map Name"
@export var environment : WorldEnvironment
@export var grids : Dictionary
@export var transition_points : Dictionary
@export var player_current_x_pos : int
@export var player_current_z_pos : int

func on_map_enter() -> void:
	pass

func on_map_tick_update() -> void:
	pass

func on_map_exit() -> void:
	pass
