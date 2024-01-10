extends PanelContainer

onready var Tile_name: Label = $Propriety/Tile_name

var tile

func tile_selected(item) -> void:
	tile = item
	
	Tile_name.text = item.name

func translation_value(value: bool) -> void:
	for child in get_child(0).get_children():
		if child.get("propriety") != null:
			if value:
				child.start()
			else:
				child.clear()
