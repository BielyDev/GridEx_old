extends Node

signal finished()

func start() -> void:
	Index.block_view = true
	Index.edit_node.warning_pc(
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
