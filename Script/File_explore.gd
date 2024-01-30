extends Control

signal OK(dir)
signal CANCEL()

onready var Filex: FileDialog = $FileDialog

var files: Array = []
var exporting: bool = false


func _ready() -> void:
	UI.ready_animated_complex(Filex,$Background)
	
	Filex.show()
	Filex.filters = files
	Filex.show_hidden_files = false
	
	Filex.dialog_text = str(Filex.current_file,".",files[0])


func _input(_event: InputEvent) -> void:
	var extension = Filex.current_file.get_extension()
	var file_name_filter = Filex.current_file.replace(".","").replace(Filex.current_file.get_extension(),"")
	var file_name
	if extension == "":
		file_name = str(file_name_filter,files[0].replace("*",""))
	else:
		file_name = str(file_name_filter,".",extension)
	
	Filex.dialog_text = file_name



func _selection_file_and_dir(path) -> void:
	if exporting:
		return
	exporting = true
	
	yield(UI.queue_animated_complex(self,Filex,$Background),"completed")
	
	if path is String:
		emit_path(path)
	if path is PoolStringArray:
		for paths in path:
			emit_path(paths)

func emit_path(path: String) -> void:
	var extension = path.get_extension()
	var file_name: String = path.get_file().replace(extension,"")
	
	
	emit_signal("OK",path,file_name)
	queue_free()


func _cancel() -> void:
	yield(UI.queue_animated_complex(self,Filex,$Background),"completed")
	
	emit_signal("CANCEL")
	queue_free()


func _on_FileDialog_file_selected(path: String) -> void:
	_selection_file_and_dir(path)


func _on_FileDialog_popup_hide() -> void:
	_cancel()
func _on_FileDialog_hide() -> void:
	_cancel()



func _on_FileDialog_files_selected(paths: PoolStringArray) -> void:
	_selection_file_and_dir(paths)

func _on_FileDialog_dir_selected(dir: String) -> void:
	_selection_file_and_dir(str(dir,"/",Filex.dialog_text))
