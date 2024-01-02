extends Node

signal finished()

var expr = ("res://Scene/Popups/Export_Godot_config.tscn")

func start() -> void:
	Index.block_view = true
	
	IndexLayer.file_explore(
		["tscn"],
		self,
		"ok",
		"cancel"
	)

func ok(dir):
	IndexLayer.call_export(expr,dir,self,"final")
	Index.block_view = true

func final():
	emit_signal("finished")
	Index.block_view = false

func cancel():
	emit_signal("finished")
	Index.block_view = false
