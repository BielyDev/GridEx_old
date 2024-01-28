extends Control


func _ready() -> void:
	Index.view2d.preview2d = self


func _on_Screen_Mouse_mouse_entered() -> void:
	Index.block_view = false

func _on_Screen_Mouse_mouse_exited() -> void:
	Index.block_view = true
