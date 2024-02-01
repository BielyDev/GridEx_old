extends Node

var save: bool
var scene_name: String

func _ready() -> void:
	OS.set_window_title("[no save] - GridEx")
	Index.block.connect("tile_added",self,"_verification_refresh")
	Index.connect("save_project",self,"_save_project")

func _verification_refresh() -> void:
	OS.set_window_title(str("*[",scene_name,"] - GridEx"))

func _save_project(project_name: String) -> void:
	OS.set_window_title(str("[",project_name,"] - GridEx"))
	
	scene_name = project_name
