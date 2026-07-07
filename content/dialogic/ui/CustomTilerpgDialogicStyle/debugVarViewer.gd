extends RichTextLabel

@onready var debugHost = get_node("debug")
# get_node("debugVariables/debug").set_text("testing")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func writeVariables():
	text = "testing"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	writeVariables()
