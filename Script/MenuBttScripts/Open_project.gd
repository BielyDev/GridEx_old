extends Node

signal finished()

func start() -> void:
	Index.block_view = true
	
	IndexLayer.file_explore(
		["*.gridex"],
		self,
		"ok",
		"cancel"
	)

func ok(dir: String, file:String):
	Save.open_project(dir)
	Index.block_view = true

func cancel():
	emit_signal("finished")
