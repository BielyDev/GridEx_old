extends AnimationButtonClass

class_name TileButton

var Tile: MeshInstance

func _ready() -> void:
	rect_pivot_offset = rect_size/2

func index() -> void:
	Index.tile.tile = Tile
	Index.tile.icon = icon
