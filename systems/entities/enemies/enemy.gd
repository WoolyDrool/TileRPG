extends TickEntity
class_name EnemyEntity

@export var enemy_data : EnemyData
@export var health_component : HealthComponent
@export var death_component : DeathComponent

func _ready() -> void:
	super()
	# Load Enemy Variables
	health_component.current_health = enemy_data.enemy_starting_health
	health_component.max_health = enemy_data.enemy_starting_health

func _tick_process() -> void:
	if health_component.current_health <= 0:
		print("I reacted to the games updating")
		death_component.die()
	pass
