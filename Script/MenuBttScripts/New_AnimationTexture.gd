extends Node

signal finished()

func start() -> void:
	get_parent().text = "[Animation Texture]"
	
	emit_signal("finished")
