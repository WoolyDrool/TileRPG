class_name HealthComponent
extends Area3D

@export var max_health : int = 3
@export var current_health : int
@export var max_armor : int = 3
@export var current_armor : int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func take_damage(incoming_damage : int):
	current_health -= incoming_damage
	print("took damage, current health now ", current_health)
