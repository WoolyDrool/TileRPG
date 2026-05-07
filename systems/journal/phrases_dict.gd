class_name JournalPhrasesDict
extends Node

@export var character_reference : JournalPhraseCharacter
var gawain_character_name : String = "Gawain"
var gawain_sword_text : String = "that broken sword"
var gawain_sword_journal_text : String = "your broken sword"
var gawain_sword_journal_text_has_completed : bool = false

@export var test_dict = {
	gawain_character_name: 
		[gawain_sword_text, gawain_sword_journal_text, gawain_sword_journal_text_has_completed]
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(test_dict[character_reference.character_name][0])
	print(test_dict[character_reference.character_name][1])
	print(test_dict[character_reference.character_name][2])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
