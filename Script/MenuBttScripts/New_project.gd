extends Node

signal finished()

func start() -> void:
	Index.block_view = true
	Index.edit_node.warning_pc(
		"VOCÊ IRAR PERDER SEU PROJETO ATUAL. \n DESEJA CONTINUAR?",
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
