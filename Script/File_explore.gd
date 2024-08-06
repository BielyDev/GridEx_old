extends Control

signal OK(dir)
signal CANCEL()

onready var Filex: FileDialog = $FileDialog
onready var Save_path: PanelContainer = $Save_path
onready var vbox: VBoxContainer = $Save_path/Vbox

var files: Array = []
var exporting: bool = false


func _ready() -> void:
	_create_button_path()
	
	Save_path.rect_position.x = Filex.rect_position.x + (Save_path.rect_size.x + 10)
	Save_path.rect_position.y = Filex.rect_position.y
	
	UI.ready_animated_complex(Filex,$Background)
	UI.ready_animated_complex(Save_path,$Background)
	
	if Index.save_path_explorer.size() >= 1:
		Filex.current_path = Index.save_path_explorer[Index.save_path_explorer.size()-1]
	
	Filex.show()
	Filex.filters = files
	Filex.show_hidden_files = false
	
	Filex.dialog_text = str(Filex.current_file,".",files[0])


func _input(_event: InputEvent) -> void:
	Save_path.rect_position.x = Filex.rect_position.x - (Save_path.rect_size.x + 10)
	Save_path.rect_position.y = Filex.rect_position.y
	
	var extension = Filex.current_file.get_extension()
	var file_name_filter = Filex.current_file.replace(".","").replace(Filex.current_file.get_extension(),"")
	var file_name
	
	if extension == "":
		file_name = str(file_name_filter,files[0].replace("*",""))
	else:
		file_name = str(file_name_filter,".",extension)
	
	Filex.dialog_text = file_name


func _create_button_path() -> void:
	for path in Index.save_path_explorer:
		var button = ButtonPath.new()
		
		button.path = path
		button.FileDialogPath = Filex.get_path()
		vbox.add_child(button)


func _selection_file_and_dir(path) -> void:
	if exporting:
		return
	exporting = true
	
	
	if path is String:
		emit_path(path)
	if path is PoolStringArray:
		for paths in path:
			emit_path(paths)
	
	print(Filex.current_dir)
	
	for i in Index.save_path_explorer:
		if i == str(Filex.current_dir,"/"):
			Index.save_path_explorer.erase(i)
	
	Index.save_path_explorer.insert(0,str(Filex.current_dir,"/"))
	
	
	yield(UI.queue_animated_complex(self,Save_path,$Background),"completed")
	yield(UI.queue_animated_complex(self,Filex,$Background),"completed")


func emit_path(path: String) -> void:
	var extension = path.get_extension()
	var file_name: String = path.get_file().replace(extension,"")
	
	
	emit_signal("OK",path,file_name)
	queue_free()


func _cancel() -> void:
	yield(UI.queue_animated_complex(self,Save_path,$Background),"completed")
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
