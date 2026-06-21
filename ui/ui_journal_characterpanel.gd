extends Control

@export var assoc_character : DialogicCharacter
@export var assoc_glossary : DialogicGlossary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	propogate_blurb_labels(assoc_character)
	propogate_phrase_buttons(assoc_glossary)

func propogate_blurb_labels(_assoc_character : DialogicCharacter):
	if _assoc_character:
		%NameLabel.text = _assoc_character.display_name
		%PronounLabel.text = ("(" + _assoc_character.nicknames[0] + ")")
		%BioLabel.text = _assoc_character.description

func propogate_phrase_buttons(_assoc_glossary : DialogicGlossary):
	if _assoc_glossary:
		var debug = _assoc_glossary.get_entry("consumed with angst")
		print(debug.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
