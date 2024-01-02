extends TileButton


func _pressed() -> void:
	index()
	Index.edit.enabled = true
	Index.edit.scene_path = "res://Scene/Popups/Light_Control.tscn"
	
	var scene = load(Block_scene)
	Index.emit_signal("model_tile_selection",null)
	Index.emit_signal("change_tile")

