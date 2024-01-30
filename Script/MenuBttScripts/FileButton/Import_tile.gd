extends Node

signal finished()

var expr = ("res://Scene/Popups/Export_Godot_config.tscn")

func start() -> void:
	Index.block_view = true
	
	IndexLayer.file_explore(
		["*.tile"],
		self,
		"ok",
		"cancel",
		FileDialog.MODE_OPEN_FILE
	)

func ok(dir: String,file: String) -> void:
	
	if dir.get_extension() != "tile":
		IndexLayer.popup_one('The file type must be "tile"!')
		return
	
	Import.import_group_tile_automatic(dir,true)

func cancel() -> void:
	emit_signal("finished")
