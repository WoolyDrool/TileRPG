extends Control

@export var open_journal_action : GUIDEAction
@export var close_journal_action : GUIDEAction
var journal_open : bool = false
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var background : Control = $Background
@onready var open_sound_player : AudioStreamPlayer = $Sounds/OpenSound
@onready var close_sound_player : AudioStreamPlayer = $Sounds/CloseSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gameplay_input()

func gameplay_input():
	if open_journal_action.is_triggered():
		print("awawa")
		if !journal_open:
			open_journal()
	if close_journal_action.is_triggered():
		if journal_open:
			close_journal()

func open_journal():
	background.visible = true
	journal_open = true
	open_sound_player.play()
	animation_player.play("journal_open")
	SignalBus.change_input_mode_to_ui.emit()
	
func close_journal():
	close_sound_player.play()
	animation_player.play("journal_close")
	SignalBus.change_input_mode_to_gameplay.emit()
	journal_open = false	
