extends Button

export(int, "VOID","ADD","REMOVE") var mode: int 
export(String) var key: String 

func _input(event: InputEvent) -> void:
	if Index.mode == mode:
		modulate = Color.purple
	else:
		modulate = Color.white

func _pressed() -> void:
	Index.mode = mode

func _unhandled_key_input(_event: InputEventKey) -> void:
	if Input.is_action_just_pressed(key):
		Index.mode = mode
