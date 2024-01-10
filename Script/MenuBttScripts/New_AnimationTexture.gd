extends Node

signal finished()

func start() -> void:
	get_parent().text = "[Animated Texture]"
	get_parent().get_parent().get_parent().animated()
	
	emit_signal("finished")
