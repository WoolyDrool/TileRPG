extends Control

@export var dialogic_text_node : DialogicNode_DialogText
@export var shell_text_node : TextEdit
@export var caret_sprite : TextureRect

@export_category("Inputs")
@export var enter_selector_action : GUIDEAction
@export var exit_selector_action : GUIDEAction
@export var move_caret_left_action : GUIDEAction
@export var move_caret_right_action : GUIDEAction
@export var select_action : GUIDEAction
@export var confirm_select_action : GUIDEAction

var selecting : bool = false
var current_text : String
var selector_scrubbed_text : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	caret_sprite.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handle_inputs()
	
	dialogic_text_node.visible = !selecting
	caret_sprite.visible = selecting
	shell_text_node.visible = selecting
	
	if selecting:
		handle_selector_caret_input_gamepad()
		update_caret_sprite_position()
		scrub_dialogic_text()

func handle_inputs():
	if enter_selector_action.is_triggered():
		if !selecting:
			enter_selector_mode()
	elif exit_selector_action.is_triggered():
		if selecting:
			exit_selector_mode()
	
func enter_selector_mode():
	selecting = true
	print("TextSelector: Entered Selector Mode")
	SignalBus.change_input_mode_to_ui_selector.emit()
	DialogicUtil.autoload().Inputs.custom_block_input(true)
	
	shell_text_node.text = dialogic_text_node.get_parsed_text()

func handle_selector_caret_input_gamepad():
	#TODO: Get the caret moving with the defined GUIDE actions
	#TODO: Snap the caret to being per word instead of per character
	#TODO: Snap to maximum of 3 words. Check if line has no more than 2 spaces
	var origin_line = shell_text_node.get_caret_line()
	var origin_column = shell_text_node.get_caret_column()
	var new_caret_line = origin_line
	var new_caret_column = origin_column
	if move_caret_left_action.is_triggered():
		print("got left")
		new_caret_line -= 1
		shell_text_node.select(origin_line, origin_line, new_caret_line, new_caret_column)
	elif  move_caret_right_action.is_triggered():
		new_caret_line += 1
		shell_text_node.select(origin_line, origin_line, new_caret_line, new_caret_column)
	
func update_caret_sprite_position():
	var current_caret_pos = shell_text_node.get_caret_draw_pos()
	var screen = get_global_transform_with_canvas().origin
	caret_sprite.global_position = current_caret_pos - screen

func scrub_dialogic_text():
	if confirm_select_action.is_triggered():
		var test_to_try = shell_text_node.get_selected_text()
		if get_dialogic_glossary_entry(test_to_try):
			print("Congratulations! You Won!")
		else:
			print("No glossary found for that text")

func get_dialogic_glossary_entry(attempted_phrase : String) -> bool:
	if Dialogic.Glossary.get_entry(attempted_phrase):
		return true
	else:
		return false
	
func exit_selector_mode():
	SignalBus.change_input_mode_to_ui.emit()
	print("TextSelector: Exited Selector Mode")
	DialogicUtil.autoload().Inputs.custom_block_input(false)
	selecting = false

func _on_dialogic_node_dialog_text_finished_revealing_text() -> void:
	current_text = dialogic_text_node.text
