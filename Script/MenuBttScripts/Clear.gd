extends Node

signal finished()

func start() -> void:
	get_parent().text = "[empty]"
	get_parent().get_parent().get_parent().clear()
	
	emit_signal("finished")
