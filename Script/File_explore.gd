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


func _unhandled_key_input(_event: InputEventKey) -> void:
	var file_name_filter = Filex.current_file.replace(".","").replace(Filex.current_file.get_extension(),"")
	var file_name = str(file_name_filter,files[0])
	
	Filex.dialog_text = file_name.replace("*","")



func _selection_file_and_dir() -> void:
	if exporting:
		return
	exporting = true
	
	
	yield(UI.queue_animated_complex(self,Filex,$Background),"completed")
	
	var file_name_filter = Filex.current_file.replace(".","").replace(Filex.current_file.get_extension(),"")
	var file_name = str(file_name_filter,files[0]).replace("*","")
	
	var dir = str(Filex.current_dir,"/",file_name).replace("*","")
	
	emit_signal("OK",dir,file_name)
	queue_free()


func _cancel() -> void:
	yield(UI.queue_animated_complex(self,Filex,$Background),"completed")
	
	emit_signal("CANCEL")
	queue_free()



func _on_FileDialog_confirmed() -> void:
	_selection_file_and_dir()
func _on_FileDialog_file_selected(path: String) -> void:
	_selection_file_and_dir()


func _on_FileDialog_popup_hide() -> void:
	_cancel()
func _on_FileDialog_hide() -> void:
	_cancel()

