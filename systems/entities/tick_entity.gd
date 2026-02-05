extends Node3D
class_name TickEntity

## TickEntity is the global parent class of all entities that live on the grid and react to tick updates.
## 
## 

func _ready() -> void:
	Globals.time_advance_tick.connect(_tick_process)

## The shell process for updating entity states whenever the game advances
func _tick_process() -> void:
	pass
