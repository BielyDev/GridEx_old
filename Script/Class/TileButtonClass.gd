extends AnimationButtonClass

class_name TileButton

var Tile: Tile
var id_text = Label.new()

func _ready() -> void:
	center_pivot()
	speed = 0.2
	
	add_child(id_text)
	id_text.hide()
	id_text.text =  str(Tile.id_tile)

func index() -> void:
	Index.tile.id_tile = Tile.id_tile
	Index.tile.id_group = Tile.id_group
	Index.tile.icon = icon
