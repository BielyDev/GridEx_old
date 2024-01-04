extends PanelContainer

onready var Tile_name: Label = $Propriety/Tile_name

var tile

func tile_selected(item) -> void:
	tile = item
	
	Tile_name.text = item.name
