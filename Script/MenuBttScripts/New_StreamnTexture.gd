extends Node

signal finished()

func start() -> void:
	get_parent().get_parent().get_parent().stream()
	
	emit_signal("finished")
