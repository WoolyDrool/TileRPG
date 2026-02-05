extends Node3D
class_name RoomTile

@export var front_wall_visislbe : bool = true
@export var back_wall_visislbe : bool = true
@export var right_wall_visislbe : bool = true
@export var left_wall_visislbe : bool = true
@export var ceiling_visislbe : bool = true

func update_wall_states():
	$"%Front Wall".visible = front_wall_visislbe
	$"%Back Wall".visible = back_wall_visislbe
	$"%Right Wall".visible = right_wall_visislbe
	$"%Left Wall".visible = left_wall_visislbe
	$%Ceiling.visible = ceiling_visislbe

func bake_room():
	#TODO: Bake the room down into a single object, without a script (for performance)
	pass
