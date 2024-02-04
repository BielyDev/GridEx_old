extends Node

onready var Edit: CanvasLayer = $"../.."
onready var time: Timer = $save_time



func start(_timer: int) -> void:
	
	time.wait_time = _timer * 60
	time.start()
func stop() -> void:
	time.stop()

func _on_save_time_timeout() -> void:
	if Edit.save_dir != "":
		Save.save_project(Edit.save_dir)
