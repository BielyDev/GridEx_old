extends Control


func _on_View_mouse_entered() -> void:
	Index.block_view = false


func _on_View_mouse_exited() -> void:
	Index.block_view = true

