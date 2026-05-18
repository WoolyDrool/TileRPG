class_name InputManager
extends Node

@export_category("Gamepad")
@export var switch_to_gamepad : GUIDEAction
@export var global_gamepad : GUIDEMappingContext
@export var move_mode_gamepad : GUIDEMappingContext
@export var ui_mode_gamepad : GUIDEMappingContext
@export var ui_mode_selector_gamepad : GUIDEMappingContext

@export_category("KBM")
@export var switch_to_kbm : GUIDEAction
@export var global_kbm : GUIDEMappingContext
@export var move_mode_kbm : GUIDEMappingContext
@export var ui_mode_kbm : GUIDEMappingContext

enum GAME_MODE {MOVE, UI, UI_SELECTOR}
var game_mode : GAME_MODE = GAME_MODE.MOVE

enum INPUT_MODE {KBM, GAMEPAD}
var input_mode : INPUT_MODE = INPUT_MODE.GAMEPAD

func _ready() -> void:
	connect_signals()
	update_input()
	
func connect_signals():
	switch_to_gamepad.triggered.connect(set_input_mode.bind(INPUT_MODE.GAMEPAD))
	switch_to_kbm.triggered.connect(set_input_mode.bind(INPUT_MODE.KBM))
	SignalBus.change_input_mode_to_gameplay.connect(set_gamemode.bind(GAME_MODE.MOVE))
	SignalBus.change_input_mode_to_ui.connect(set_gamemode.bind(GAME_MODE.UI))
	SignalBus.change_input_mode_to_ui_selector.connect(set_gamemode.bind(GAME_MODE.UI_SELECTOR))
	
func update_input():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	match input_mode:
		INPUT_MODE.KBM:
			GUIDE.enable_mapping_context(global_kbm, true)
			print("InputManager: Current Input Mode - KBM")
			match game_mode:
				GAME_MODE.MOVE:
					GUIDE.enable_mapping_context(move_mode_kbm)
					print("InputManager: Current Game Mode - Movement")
				GAME_MODE.UI:
					Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
					GUIDE.enable_mapping_context(ui_mode_kbm)
					print("InputManager: Current Game Mode - UI")
		INPUT_MODE.GAMEPAD:
			GUIDE.enable_mapping_context(global_gamepad, true)
			print("InputManager: Current Input Mode - Gamepad")
			match game_mode:
				GAME_MODE.MOVE:
					GUIDE.enable_mapping_context(move_mode_gamepad)
					print("InputManager: Current Game Mode - Movement")
				GAME_MODE.UI:
					GUIDE.enable_mapping_context(ui_mode_gamepad)
					print("InputManager: Current Game Mode - UI")
				GAME_MODE.UI_SELECTOR:
					GUIDE.enable_mapping_context(ui_mode_selector_gamepad)
					print("InputManager: Current Game Mode - UI Selector")

func set_gamemode(_game_mode : GAME_MODE):
	game_mode = _game_mode
	update_input()

func set_input_mode(_input_mode : INPUT_MODE):
	input_mode = _input_mode
	update_input()
