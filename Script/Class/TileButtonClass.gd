extends AnimationButtonClass

class_name TileButton

export(String) var Block_scene: String

func _ready() -> void:
	rect_pivot_offset = rect_size/2

func index() -> void:
	button_animated()
	
	Index.tile.path = Block_scene
	Index.tile.icon = icon
