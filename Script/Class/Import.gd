extends GridEx

class_name Import


static func import_tscn(path: String):
	
	var scene = load(path)
	if scene == null:
		IndexLayer.popup_one("Dependency error!")
		return
	
	var no = scene.instance()
	
	Index.edit_node.World3D.Block.add_child(no)
	
	yield(create_time(1),"timeout")
	
	loop_child_importer(no)


static func loop_child_importer(block_0) -> void:
	if block_0.get_child_count() >= 1:
		for block_1 in block_0.get_children():
			
			var block_pos = block_1.global_transform.origin.snapped(Vector3(2,2,2)) + Vector3(0,1,0)
			
			Index.edit_node.World3D.Block.block_pos.append(
				{pos = block_pos, tile = block_1}
			)
			
			loop_child_importer(block_1)
			
			if block_1 is OmniLight:
				var spr = Sprite3D.new()
				spr.texture = load("res://Assets/2D/Atlas/Light.tres")
				spr.pixel_size = 0.0093
				spr.billboard = SpatialMaterial.BILLBOARD_ENABLED
				
				block_1.add_child(spr)


static func import_group_tile_automatic(path: String,loader_id: bool = false) -> void:
	var tile_menu: PackedScene = preload("res://Scene/Theme_Tile/Basic.tscn")
	var scene
	var no
	
	if loader_id:
		var file = File.new()
		#LEITURA===========================================
		file.open(path,File.READ)
		
		var load_data = parse_json(file.get_as_text())
		file.close()
		#DESCOMPACTA=======================================
		var path_scene_descompct = str(path,randi(),".tscn")
		file.open(path_scene_descompct,file.WRITE)
		file.store_string(load_data.scene)
		file.close()
		#==================================================
		
		
		var scene_descompact = load(path_scene_descompct)
		
		scene = scene_descompact
		no = scene.instance()
		
		
		var save_data = {id = load_data.id,id_tile = load_data.id_tile,id_group = load_data.id_group}
		
		
		_load_file_config(no,save_data,true)
		
		delete_file(path_scene_descompct)
	else:
		scene = load(path)
		no = scene.instance()
		
		_load_file_config(no,{},false)
	
	
	var basic = tile_menu.instance()
	
	basic.tittle = no.name
	basic.name = no.name
	basic.group_scene = no
	
	for child in Index.edit_node.Tile_groups.get_children():
		if child.name == basic.tittle:
			basic.name = str(no.name,"_",Index.edit_node.Tile_groups.get_children().size())
	
	Index.edit_node.Tile_groups.add_child(basic)



static func _load_file_config(no,save_data: Dictionary,loader_id: bool) -> void:
	var tile_class_script: Script = load("res://Script/Class/Tile.gd")
	var tile_group_class_script: Script = load("res://Script/Class/Tile_Group.gd")
	
	
	
	#Set scripts----------------------------------
	if no.get_script() == null:
		no.set_script(tile_group_class_script)
	for tiles in no.get_children():
		if tiles.get_script() == null:
			tiles.set_script(tile_class_script)
	#---------------------------------------------
	
	if loader_id == false:
		if no.id_group == -1:
			no.id_group = int(randi())
		
		for tiles in no.get_children():
			if tiles.id_tile == -1:
				tiles.id_tile = tiles.get_index()
				tiles.id_group = no.id_group
	else:
		no.id_group = save_data.id_group
		for tiles in no.get_children():
			for id in save_data.id:
				if tiles.get_index() == id:
					tiles.id_tile = save_data.id_tile[id]
					tiles.id_group = save_data.id_group
					#tiles.id = save_data.id[id]

