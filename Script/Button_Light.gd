extends TileButton

func _pressed() -> void:
	index()
	
	var scene = load(Block_scene)
	var preview = scene.instance()
	Index.emit_signal("model_tile_selection",null)
	Index.emit_signal("change_tile")
