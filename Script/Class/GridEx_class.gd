extends Node

class_name GridEx , "res://Assets/2D/Program/Icon/icon.svg"

static func create_time(sec: float = 1.0) -> Timer:
	var time = Timer.new()
	Index.add_child(time)
	
	time.wait_time = 2
	time.start()
	
	return time

static func delete_file(path: String) -> void:
	var dic = Directory.new()
	dic.remove(path)
