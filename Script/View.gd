extends Control


func _on_Preview2D_mouse_entered() -> void:
	Index.block_view = false

func _on_Preview2D_mouse_exited() -> void:
	Index.block_view = true
