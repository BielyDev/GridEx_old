extends Node

onready var Par: Control = $".."

var path: String = ("res://Assets/Execute_import/")

func _on_Open_pressed() -> void:
	if Par.is_tree_selection() == false:
		IndexLayer.popup_one("Selecione algum grupo antes!",self,"open_confirm")
		return
	
	IndexLayer.file_explore(
		["*.obj"],
		self,
		"file_ok",
		"file_null",
		FileDialog.MODE_OPEN_FILE
	)


func open_confirm() -> void:
	pass


func file_ok(dir: String,file_name: String) -> void:
	var file_import
	var extension_file: String
	var save: String
	var file = File.new()
	
	file.open(dir,File.READ)
	file_import = file.get_as_text(false)
	file.close()
	
	
	if dir.ends_with("obj"):
		extension_file = ".obj"
	if dir.ends_with("gltf"):
		extension_file = ".gltf"
	
	dir = dir.substr(0,dir.length() - extension_file.length())
	file_name = file_name.substr(0,file_name.length() - extension_file.length())
	
	#if extension_file == ".obj":
	#	save_mtl(dir,file_name)
	
	save = str(path,file_name,extension_file)
	
	#file.open(save,File.WRITE)
	#file.store_string(file_import)
	#file.close()
	
	var mesh = ObjParse.load_obj(str(dir,extension_file))
	
	var MeshIns = MeshInstance.new()
	
	Par.add_item(MeshIns,file_name)
	MeshIns.mesh = mesh


func save_mtl(dir,file_name: String) -> void:
	var save_mtl = str(path,file_name,".mtl")
	var open_mtl = str(dir,".mtl")
	var file_mtl = File.new()
	
	file_mtl.open(open_mtl,File.READ)
	var cod_mtl = file_mtl.get_as_text()
	file_mtl.close()
	
	file_mtl.open(str("res://Assets/Execute_import/",file_name,".mtl"),File.WRITE)
	file_mtl.store_string(cod_mtl)
	file_mtl.close()


func file_null() -> void:
	print("não achei")
