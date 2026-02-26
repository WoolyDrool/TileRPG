class_name InteractionManager
extends Node3D

@onready var selection_sprite : Sprite3D = $SelectorSprite
@onready var shapecast : ShapeCast3D = $ShapeCast3D
@onready var cooldown_timer : Timer = $InteractionCooldownTimer
var in_range_interactables = []
var current_interaction_index : int = 0
var current_interaction_index_max : int = 0
var can_scan : bool = true
var collision_count : int
var can_cycle : bool = false
var wanted_position : Vector3
var lerp_speed : float = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scan_for_interacts") and can_scan:
		scan_for_new_interactables()
	
	selector_cycle_next() 

func _physics_process(delta: float) -> void:
	selection_sprite.global_position = lerp(selection_sprite.global_position, wanted_position, lerp_speed * delta)

func scan_for_new_interactables() -> void:
	can_scan = false
	in_range_interactables.clear()
	collision_count = shapecast.get_collision_count()
	current_interaction_index_max = collision_count
	print("InteractionManager: Collision Count - ", collision_count)
	
	for i in range(collision_count):
		var collider = shapecast.get_collider(i)
		print(collider.entity_name)
		in_range_interactables.append(collider)
			
	if collision_count == shapecast.get_collision_count():
		cooldown_timer.start()
	
func selector_cycle_next():
	if Input.is_action_just_pressed("attack_right"):
		current_interaction_index += 1
		clampi(current_interaction_index, 0, current_interaction_index_max)
		print("InteractionManager: Cycling interaction to ", current_interaction_index)
	elif Input.is_action_just_pressed("attack_left"):
		current_interaction_index += -1
		clampi(current_interaction_index, 0, current_interaction_index_max)
		print("InteractionManager: Cycling interaction to ", current_interaction_index)
	
	# Wrap back to 0
	if current_interaction_index >= current_interaction_index_max:
		current_interaction_index = 0 
	elif current_interaction_index < 0:
		current_interaction_index = 0
	
	if collision_count > 0:
		wanted_position = in_range_interactables.get(current_interaction_index).global_position
		#selection_sprite.global_position = in_range_interactables.get(current_interaction_index).global_position
	
func _on_interaction_cooldown_timer_timeout() -> void:
	can_scan = true
