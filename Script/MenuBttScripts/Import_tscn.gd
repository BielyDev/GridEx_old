extends Node

signal finished()

func start() -> void:
	Index.block_view = true
	
	IndexLayer.file_explore(
		["*.tscn"],
		self,
		"ok",
		"cancel",
		FileDialog.MODE_OPEN_FILE
	)

func ok(dir: String,file: String) -> void:
	
	if dir.get_extension() != "tscn":
		IndexLayer.popup_one('The file type must be "tscn"!')
		return
	
	Import.import_tscn(dir)

func cancel() -> void:
	emit_signal("finished")
