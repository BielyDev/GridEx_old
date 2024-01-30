extends GridEx

class_name Save

static func save_project(dir: String) -> void:
	var file = File.new()
	
	file.open(dir,File.WRITE)
	
	var save_array = {layers = [],tiles = [],tiles_groups = []}
	
	save_layers_and_tile(Index.block,save_array.layers,save_array.tiles)
	
	#Scene------------------
	var save_scenes = [] #{Basic_tile = cena}
	var paths = []
	
	for groups in Index.edit_node.Tile_groups.get_children():
		yield(create_time(0.2),"timeout")
		
		
		var path = str(dir,int(randi()),".tscn")
		paths.append(path)
		
		var group_scene: PackedScene = PackedScene.new()
		group_scene.pack(groups.group_scene)
		
		Export.file_tile_create(path,group_scene,groups.group_scene,false)
	
	
	var open_scenes = [] #{Basic_tile = cena}
	for path in paths:
		
		var fil = File.new()
		fil.open(path,File.READ)
		
		var arq = fil.get_as_text()
		fil.close()
		
		open_scenes.append(arq)
		
		delete_file(path)
	
	
	save_array.tiles_groups = (open_scenes)
	
	file.store_string(to_json(save_array))
	file.close()


static func open_project(dir: String) -> void:
	
	var file = File.new()
	
	file.open(dir,File.READ)
	
	var load_file_ant = file.get_as_text()
	file.close()
	var load_file = parse_json(load_file_ant)
	
	for child in Index.block.get_children():
		child.queue_free()
	
	loader_tiles_and_layers(load_file,dir)
	


static func loader_tiles_and_layers(load_file: Dictionary,dir: String) -> void:
	
	for groups in load_file.tiles_groups:
		var path = str(dir,int(randi()),".tscn")
		var file = File.new()
		
		file.open(path,File.WRITE)
		file.store_string(groups)
		file.close()
		
		Import.import_group_tile_automatic(path,true)
		
		delete_file(path)
	
	
	for layers in load_file.layers:
		var new_layer = Spatial.new()
		new_layer.name = layers.name
		
		Index.block.add_child(new_layer)
	
	
	for tiles in (load_file.tiles):
		var mesh = Tile.new()
		
		for groups in Index.edit_node.Tile_groups.get_children():
			
			if groups.group_scene.id_group == tiles.id_group:
				for tile in groups.group_scene.get_children():
					
					if tile.id_tile == tiles.id_tile:
						mesh = tile.duplicate()
		
		
		Index.block.get_child(tiles.layer).add_child(mesh)
		var sem_aspas: String = (tiles.position.replace("(","").replace(")",""))
		var pos_string = sem_aspas.replace(",","")
		
		var pos_vect = Vector3(
			float(pos_string.split(" ")[0]),
			float(pos_string.split(" ")[1]),
			float(pos_string.split(" ")[2])
			)
		
		mesh.global_transform.origin = pos_vect



static func save_layers_and_tile(Models: Spatial,array_layers: Array,array_tile: Array) -> void:
	for layers in Models.get_children():
		array_layers.push_back(
			{id = layers.get_index(),name = layers.name}
		)
		
		for child in layers.get_children():
			if child is OmniLight == false:
				array_tile.push_back(
					{
						id = child.get_index(),
						id_tile = child.id_tile,
						id_group = child.id_group,
						position = str(child.global_transform.origin),
						layer = layers.get_index()
					}
				)

