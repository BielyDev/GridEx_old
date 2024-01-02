extends Control

func _ready() -> void:
	Index.block_view = true

func _on_New_project_pressed() -> void:
	get_parent().queue_free()
	Index.block_view = false
