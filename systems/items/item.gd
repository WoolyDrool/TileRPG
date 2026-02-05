class_name Item
extends Resource

@export var item_name : String
@export var item_sprite : Texture2D

enum ITEM_TYPES {CONSUMABLE, WEAPON}
@export var item_type : ITEM_TYPES

@export var item_drop_chance : float = 1.0
