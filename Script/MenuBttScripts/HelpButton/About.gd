extends Node

signal finished()

func start() -> void:
	OS.shell_open("https://bielydev.itch.io/gridex")
	emit_signal("finished")
