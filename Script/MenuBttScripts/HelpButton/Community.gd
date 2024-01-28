extends Node

signal finished()

func start() -> void:
	OS.shell_open("https://bielydev.itch.io/gridex/community")
	emit_signal("finished")
