extends Control

@export var dialogic_text_node : DialogicNode_DialogText
@export var enter_selector_action : GUIDEAction
var selecting : bool = false
var current_text : String
var selector_scrubbed_text : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enter_selector_action.is_triggered():
		if !selecting:
			enter_selector_mode()
		else:
			exit_selector_mode()
	
	dialogic_text_node.selection_enabled = selecting
	
	if selecting:
		handle_selector_cursor_input_gamepad()
	
func enter_selector_mode():
	selecting = true
	print("TextSelector: Entered Selector Mode")
	SignalBus.change_input_mode_to_ui_selector.emit()
	#Dialogic.Glossary.get_entry()

func handle_selector_cursor_input_gamepad():
	#TODO: Get the caret moving with the defined GUIDE actions
	#TODO: Snap the caret to being per word instead of per character
	#TODO: Snap to maximum of 3 words
	pass

func scrub_dialogic_text():
	#TODO: Get text from the caret selector
	pass

func get_dialogic_glossary_entry(attempted_phrase : String, glossary_entry_name : String):
	if attempted_phrase == str(Dialogic.Glossary.get_entry(glossary_entry_name)):
		return
	
func exit_selector_mode():
	selecting = false
	print("TextSelector: Exited Selector Mode")

func _on_dialogic_node_dialog_text_finished_revealing_text() -> void:
	current_text = dialogic_text_node.text
