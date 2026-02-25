class_name InteractionManager
extends Node3D

@onready var selection_sprite : Sprite3D = $SelectorSprite
@onready var shapecast : ShapeCast3D = $ShapeCast3D
@onready var cooldown_timer : Timer = $InteractionCooldownTimer
var in_range_interactables = []
var current_interaction_index : int = 0
var can_scan : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("scan_for_interacts") and can_scan:
		scan_for_new_interactables()

func scan_for_new_interactables() -> void:
	can_scan = false
	in_range_interactables.clear()
	var collision_count = shapecast.get_collision_count()
	print(collision_count)
	
	for i in range(collision_count):
		var collider = shapecast.get_collider(i)
		print(collider.entity_name)
		in_range_interactables.append(collider)
			
	if collision_count == shapecast.get_collision_count():
		cooldown_timer.start()
	
func selector_cycle_next():
	pass

func _on_interaction_cooldown_timer_timeout() -> void:
	can_scan = true
