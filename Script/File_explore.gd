extends Control

signal OK(dir)
signal CANCEL()

onready var Filex: FileDialog = $FileDialog

var files: Array = []

func _ready() -> void:
	Filex.show()
	Filex.filters = files
	Filex.show_hidden_files = false
	Filex.dialog_text = str(Filex.current_file,".",files[0])

func _unhandled_key_input(event: InputEventKey) -> void:
	Filex.dialog_text = str(Filex.current_file,".",files[0])


func _on_FileDialog_confirmed() -> void:
	var so = str(Filex.current_dir,"/",Filex.current_file)
	
	emit_signal("OK",so)
	queue_free()

func _on_FileDialog_file_selected(path: String) -> void:
	var so = str(Filex.current_dir,"/",Filex.current_file)
	
	emit_signal("OK",so)
	queue_free()

func _on_FileDialog_popup_hide() -> void:
	emit_signal("CANCEL")
	queue_free()

func _on_FileDialog_hide() -> void:
	emit_signal("CANCEL")
	queue_free()
