class_name NPCEntity
extends Node

@export var dialogic_timeline : DialogicTimeline
@export var dialogic_character : DialogicCharacter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func start_conversation():
	Dialogic.start(dialogic_timeline)
	Dialogic.timeline_ended.connect(end_conversation)
	Globals.player_seize_controls.emit()
	
func end_conversation():
	Globals.player_return_controls.emit()
