class_name JournalSelector
extends TextEdit

var current_dialogic_timeline : DialogicTimeline
var selected_words = []

@onready var quill_sprite : TextureRect = $QuillSprite
@export var selector_mode_activated : bool = true


# TODO:
# Move the caret with the D-Pad
# Select text with a maximum of 3 selectable words
# Save selected text to journal phrases system

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selector_mode_activated:
		quill_sprite.visible = true
		update_quill_sprite_position()
	else:
		quill_sprite.visible = false

func update_selector_textedit_text():
	# NOTE: This will receive the current conversation box from Dialogic and update the invisible text edit box with the appropriate text
	pass

func update_quill_sprite_position():
	var current_caret_pos = get_caret_draw_pos(get_caret_line())
	quill_sprite.position = Vector2(current_caret_pos.x, current_caret_pos.y)
