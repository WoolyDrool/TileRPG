extends Node

var json = JSON.new()
var path = "user://data.json"

var data = {}

func save_data(content):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json.stringify(content))
	file.close()
	file = null

func load_data():
	var file = FileAccess.open(path, FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	return content

func create_new_save():
	var file = FileAccess.open("res://scripts/default_save.json", FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	data = content
	save_data(content)
	
func _ready() -> void:
	create_new_save()
