class_name Reactive
extends Resource

# Refer to this video if confused
# https://www.youtube.com/watch?v=Yuw7CK5H8eA

var owner : Reactive:
	set(v):
		if owner != null:
			reactive_changed.disconnect(owner._propogate)
		owner = v
		if owner != null:
			reactive_changed.connect(owner._propogate)

signal reactive_changed(reactive)

func _init(initial_owner : Reactive = null) -> void:
	owner = initial_owner

func _propogate(_reactive : Reactive = null) -> void:
	reactive_changed.emit(self)

func manually_emit() -> void:
	reactive_changed.emit(self)
