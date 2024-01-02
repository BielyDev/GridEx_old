extends Control

func _ready() -> void:
	Index.block_view = true

func _unhandled_key_input(_event: InputEventKey) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		exit()

func _on_New_project_pressed() -> void:
	exit()

func exit() -> void:
	queue_free()
	Index.block_view = false
