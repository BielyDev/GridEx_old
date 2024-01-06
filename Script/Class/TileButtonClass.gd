extends AnimationButtonClass

class_name TileButton

var Tile: MeshInstance

func _ready() -> void:
	center_pivot()
	speed = 0.2

func index() -> void:
	Index.tile.tile = Tile
	Index.tile.icon = icon
