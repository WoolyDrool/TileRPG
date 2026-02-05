extends Node

@export var combat_manager : GridCombatManager
@export var current_weapon : Weapon
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_equipment()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if combat_manager:
		handle_combat_input()

func update_equipment():
	combat_manager.attack_damage = current_weapon.weapon_damage

func handle_combat_input() -> void:
	if current_weapon.weapon_type == Weapon.WEAPON_TYPES.MELEE:
		if Input.is_action_just_pressed("attack_forward"):
			combat_manager.attack_directional(Vector3.FORWARD)
			Globals.time_advance_tick.emit()
		elif Input.is_action_just_pressed("attack_back"):
			combat_manager.attack_directional(Vector3.BACK)
			Globals.time_advance_tick.emit()
		elif Input.is_action_just_pressed("attack_left"):
			combat_manager.attack_directional(Vector3.LEFT)
			Globals.time_advance_tick.emit()
		elif Input.is_action_just_pressed("attack_right"):
			combat_manager.attack_directional(Vector3.RIGHT)
			Globals.time_advance_tick.emit()
	elif current_weapon.weapon_type == Weapon.WEAPON_TYPES.RANGED:
		pass
		# Do Ranged Stuff
