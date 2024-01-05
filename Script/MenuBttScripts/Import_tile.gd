extends Node

signal finished()

var expr = ("res://Scene/Popups/Export_Godot_config.tscn")

func start() -> void:
	Index.block_view = true
	
	IndexLayer.file_explore(
		["*.tile","*.tscn"],
		self,
		"ok",
		"cancel",
		FileDialog.MODE_OPEN_FILE
	)

func ok(dir: String,file: String) -> void:
	Import.import_group_tile_automatic(dir)

func cancel() -> void:
	emit_signal("finished")
