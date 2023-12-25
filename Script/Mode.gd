extends Button

export(Index.MODE) var mode: int 
export(String) var key: String 

func _pressed() -> void:
	Index.mode = mode

func _unhandled_key_input(_event: InputEventKey) -> void:
	if Input.is_action_just_pressed(key):
		Index.mode = mode
