extends Button

class_name TileButton

export(String) var Block_scene: String

func _ready() -> void:
	rect_pivot_offset = rect_size/2

func index() -> void:
	Index.edit.enabled = false
	Index.animated_tween_ui(self,"rect_scale", Vector2(1.1,1.1),Vector2(1,1))
	Index.animated_tween_ui(self,"modulate", Color.violet,Color.white)
	
	Index.tile.path = Block_scene
	Index.tile.icon = icon
