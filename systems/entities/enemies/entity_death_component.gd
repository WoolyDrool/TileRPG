extends Node3D
class_name DeathComponent

func die():
	get_parent().queue_free()
