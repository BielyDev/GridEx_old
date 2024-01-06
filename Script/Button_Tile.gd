extends TileButton


func _ready() -> void:
	UI.ready_animated(self)
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


func _pressed() -> void:
	index()
	
	Index.emit_signal("model_tile_selection",Tile)
	Index.emit_signal("change_tile")
