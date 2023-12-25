extends Button

export(String) var Block_scene: String

func _pressed() -> void:
	Index.tile.path = Block_scene
	Index.tile.icon = icon
	
	var scene = load(Block_scene)
	var preview = scene.instance()
	Index.emit_signal("model_tile_selection",preview.mesh)
