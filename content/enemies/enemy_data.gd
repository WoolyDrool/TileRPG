extends Resource
class_name EnemyData

@export var enemy_name : String = "Default Enemy Name"
@export var enemy_subtitle : String = ""
@export var enemy_starting_level : int = 1
@export var enemy_starting_health : int = 4
enum ENEMY_TYPE {GROUNDED, FLYING}
@export var enemy_type : ENEMY_TYPE
#@export var loot_pool : LootPool
