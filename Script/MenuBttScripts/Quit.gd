extends Node

signal finished()

func start() -> void:
	Index.block_view = true
	IndexLayer.warning_pc(
		"DESEJA MESMO SAIR?",
		self,
		"ok",
		"cancel"
		
	)

func ok():
	get_tree().quit()
	emit_signal("finished")
	Index.block_view = false

func cancel():
	emit_signal("finished")
	Index.block_view = false
