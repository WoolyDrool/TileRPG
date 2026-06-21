class_name NPCEntity
extends Node

@export var dialogic_timeline : DialogicTimeline
@export var phrases : Dictionary[int, String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !dialogic_timeline:
		push_error("EntityNPC: No Dialogic Timeline Selected!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func start_conversation():
	Dialogic.start(dialogic_timeline)
	Dialogic.timeline_ended.connect(end_conversation)
	Globals.player_seize_controls.emit()
	SignalBus.change_input_mode_to_ui.emit()
	
func end_conversation():
	Globals.player_return_controls.emit()
	SignalBus.change_input_mode_to_gameplay.emit()
