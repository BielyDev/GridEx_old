extends Node

signal finished()

func start() -> void:
	Index.block_view = true
	IndexLayer.popup_two(
		"You will lose your current project. \n Do you wish to continue?",
		self,
		"ok",
		"cancel"
	)

func cancel():
	emit_signal("finished")
	Index.block_view = false

func ok():
	get_tree().reload_current_scene()
	emit_signal("finished")
	Index.block_view = false
