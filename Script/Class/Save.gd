extends GridEx

class_name Save

static func save_project(dir: String) -> void:
	var file = File.new()
	
	file.open(dir,File.WRITE)
	
	var save_array = {layers = [],tiles = [],tiles_groups = []}
	
	for layers in Index.block.get_children():
		save_array.layers.push_back(
			{id = layers.get_index(),name = layers.name}
		)
		
		for child in layers.get_children():
			save_array.tiles.push_back(
				{
					id = child.get_index(),
					position = str(child.global_transform.origin),
					layer = layers.get_index()
				}
			)
	
	
	var file_scenes: File = File.new()
	var save_scenes = [] #{Basic_tile = cena}
	
	file_scenes.open(str(dir,".bin"),File.WRITE)
	
	for groups in Index.edit_node.Tile_groups.get_children():
		save_scenes.append(groups.group_scene)
	
	file_scenes.store_var(save_scenes)
	file_scenes.close()
	
	yield(create_time(0.1),"timeout")
	
	file_scenes.open(str(dir,".bin"),File.READ)
	
	save_array.tiles_groups = file_scenes.get_as_text()
	file_scenes.close()
	
	yield(create_time(0.1),"timeout")
	
	print("Tiles groups:  ",save_array.tiles_groups)
	
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
	
	loader_tiles_and_layers(load_file)


static func loader_tiles_and_layers(load_file: Dictionary) -> void:
	for layers in load_file.layers:
		var new_layer = Spatial.new()
		
		new_layer.name = layers.name
		
		Index.block.add_child(new_layer)
	
	
	for child in (load_file.tiles):
		var mesh = MeshInstance.new()
		mesh.mesh = CubeMesh.new()
		
		Index.block.get_child(child.layer).add_child(mesh)
		var sem_aspas: String = (child.position.replace("(","").replace(")",""))
		var pos_string = sem_aspas.replace(",","")
		
		var pos_vect = Vector3(
			float(pos_string.split(" ")[0]),
			float(pos_string.split(" ")[1]),
			float(pos_string.split(" ")[2]))
		
		mesh.global_transform.origin = pos_vect
