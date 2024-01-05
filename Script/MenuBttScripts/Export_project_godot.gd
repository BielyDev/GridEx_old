extends Node

signal finished()

var expr = ("res://Scene/Popups/Export_Godot_config.tscn")

func start() -> void:
	Index.block_view = true
	
	IndexLayer.file_explore(
		["*.tscn"],
		self,
		"ok",
		"cancel"
	)

func ok(dir: String, file:String):
	IndexLayer.call_export(expr,dir,self,"cancel")
	Index.block_view = true

func cancel():
	emit_signal("finished")
