extends Node

signal finished()

func start() -> void:
	OS.shell_open("https://itch.io/category/3231334/new-topic")
	emit_signal("finished")
