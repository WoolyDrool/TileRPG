extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.time_advance_tick.connect(update_current_tick)

func update_current_tick():
	# Caleld whenever player moves, attacks, loots etc
	Globals.current_tick += 1
	print("Current Tick: ", Globals.current_tick)
	
func reset_current_tick(): 
	# Called every new room
	Globals.current_tick = 0
	print("Resetting Ticks. Current Tick: 0")
