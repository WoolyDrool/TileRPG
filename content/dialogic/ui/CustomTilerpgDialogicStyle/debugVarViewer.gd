extends RichTextLabel

# I'm only able to set this on startup, but hopefully it's enough for you to build on
func writeVariables():
	var qBeastStatus = "Questing Beast Status: " + Dialogic.VAR.questProgress.questingBeast.investigationStatus
	var sequenceStatus = "Sequence Status: " + Dialogic.VAR.questProgress.sequenceRepair.sequenceStatus
	text = qBeastStatus + "\n" + sequenceStatus

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	writeVariables()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
