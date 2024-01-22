extends Node

signal finished()

func start() -> void:
	get_parent().get_parent().get_parent().gradient()
	
	emit_signal("finished")
