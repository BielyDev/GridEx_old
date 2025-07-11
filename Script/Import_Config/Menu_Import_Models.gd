extends Node

onready var Par: Control = $".."

var path: String = ("res://Assets/Execute_import/")

func _on_Open_pressed() -> void:
	if Par.is_tree_selection() == false:
		IndexLayer.popup_one("Selection a group!",self,"open_confirm")
		return
	
	IndexLayer.file_explore(
		["*.obj","*.tscn"],
		self,
		"file_ok",
		"file_null",
		FileDialog.MODE_OPEN_FILES
	)


func open_confirm() -> void:
	pass


func file_ok(dir: String,file_name: String) -> void:
	if (dir.get_extension() == "obj" or dir.get_extension() == "tscn") == false:
		IndexLayer.popup_one('The file type must be "obj, tscn"!')
		return
	
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
	if dir.ends_with("tscn"):
		extension_file = ".tscn"
	
	dir = dir.substr(0,dir.length() - extension_file.length())
	file_name = file_name.substr(0,file_name.length() - extension_file.length())
	
	
	
	if extension_file == ".obj":
		var MeshIns = MeshInstance.new()
		save = str(path,file_name,extension_file)
		
		var mesh = ObjParse.load_obj(str(dir,extension_file))
		
		Par.add_item(MeshIns,file_name)
		MeshIns.mesh = mesh
	if extension_file == ".tscn":
		var tiles: Array = Import.import_tscn_tile(str(dir,extension_file))
		
		if tiles.size() == 0:
			print("erro")
			return
		for ti in tiles:
			
			var MeshIns = MeshInstance.new()
			MeshIns.mesh = ti.mesh
			
			Par.add_item(MeshIns,file_name)


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
