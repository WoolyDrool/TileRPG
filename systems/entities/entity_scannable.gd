extends Area3D
class_name ScannableEntity

@export var entity_name : String = "Default Entity Name"
@export var entity_interaction_method : String = "your_method_here"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_entity_interact():
	if get_parent().has_method(entity_interaction_method):
		get_parent().call(entity_interaction_method)
	else:
		push_warning("ScannableEntity: Parent object does not have the requested method name ", entity_interaction_method)
