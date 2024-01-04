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
	Filex.dialog_text = str(Filex.current_file,".",files[0])


func _on_FileDialog_confirmed() -> void:
	if exporting:
		return
	exporting = true
	
	var dir = str(Filex.current_dir,"/",Filex.current_file)
	
	emit_signal("OK",dir,Filex.current_file)
	queue_free()

func _on_FileDialog_file_selected(path: String) -> void:
	if exporting:
		return
	exporting = true
	
	var dir = str(Filex.current_dir,"/",Filex.current_file)
	
	yield(UI.queue_animated_complex(self,Filex,$Background),"completed")
	
	emit_signal("OK",dir,Filex.current_file)
	queue_free()

func _on_FileDialog_popup_hide() -> void:
	yield(UI.queue_animated_complex(self,Filex,$Background),"completed")
	
	emit_signal("CANCEL")
	queue_free()

func _on_FileDialog_hide() -> void:
	yield(UI.queue_animated_complex(self,Filex,$Background),"completed")
	
	emit_signal("CANCEL")
	queue_free()
