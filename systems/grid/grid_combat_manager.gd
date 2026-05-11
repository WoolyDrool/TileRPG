class_name GridCombatManager
extends Node3D

@onready var forward_ray : RayCast3D = $ForwardRay
@onready var backward_ray : RayCast3D = $BackwardRay
@onready var left_ray : RayCast3D = $LeftRay
@onready var right_ray : RayCast3D = $RightRay

@export var attack_damage : int = 0

var forward_result
var backward_result
var left_result
var right_result

var target_front : bool 
var target_back : bool 
var target_left : bool 
var target_right : bool 

func rescan_for_targets():
	# Forward
	if forward_ray.is_colliding():
		forward_result = forward_ray.get_collider()
		if forward_result.is_in_group("EntityHealth"):
			target_front = true
		else:
			target_front = false
	# Back
	if backward_ray.is_colliding():
		backward_result = backward_ray.get_collider()
		if backward_result.is_in_group("EntityHealth"):
			target_back = true
		else:
			target_back = false
	# Left
	if left_ray.is_colliding():
		left_result = left_ray.get_collider()
		if left_result.is_in_group("EntityHealth"):
			target_left = true
		else:
			target_left = false
	# Right
	if right_ray.is_colliding():
		right_result = right_ray.get_collider()
		if right_result.is_in_group("EntityHealth"):
			target_right = true
		else:
			target_right = false
			
	print(target_front, target_back, target_left, target_right)
			

@warning_ignore("unused_parameter")
# Melee Attacks
func attack_directional(dir : Vector3):
	if dir == Vector3.FORWARD:
		if target_front:
			print("GCM: Attacked Player Front")
			execute_attack(forward_result)
	elif dir == Vector3.BACK:
		if backward_result:
			print("GCM: Attacked Player Rear")
			execute_attack(backward_result)
	elif dir == Vector3.LEFT:
		if left_result:
			print("GCM: Attacked Player Left")
			execute_attack(left_result)
	elif dir == Vector3.RIGHT:
		if right_result:
			print("GCM: Attacked Player Right")
			execute_attack(right_result)

func execute_attack(target : HealthComponent):
	target.take_damage(attack_damage)
