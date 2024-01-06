extends Node

signal finished()

func start() -> void:
	Index.block_view = true
	
	IndexLayer.popup_two(
		"Do you really want to leave?",
		self,
		"ok",
		"cancel"
	)

func ok():
	get_tree().quit()
	emit_signal("finished")

func cancel():
	emit_signal("finished")
