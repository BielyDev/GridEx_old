extends TileButton

func _pressed() -> void:
	index()
	
	Index.emit_signal("model_tile_selection",Tile)
	Index.emit_signal("change_tile")
