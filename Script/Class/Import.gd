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
	
	var scene = load(path)
	var no = scene.instance()
	
	_load_file_config(no,loader_id)
	
	var basic = tile_menu.instance()
	
	basic.tittle = no.name
	basic.name = no.name
	basic.group_scene = no
	
	for child in Index.edit_node.Tile_groups.get_children():
		if child.name == basic.tittle:
			basic.name = str(no.name,"_",Index.edit_node.Tile_groups.get_children().size())
	
	Index.edit_node.Tile_groups.add_child(basic)


static func _load_file_config(no,loader_id: bool) -> void:
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
		#Criar uma nova exportação de grupos
		pass
#		for load_tiles in load_file.tiles:
#			no.id_group = load_tiles.id_group
#
#			print(load_tiles.id)
#			no.get_child(load_tiles.id).id_group = load_tiles.id_group
#			no.get_child(load_tiles.id).id_tile = load_tiles.id_tile
#
#			#for new_tiles in no.get_children():
#			#	new_tiles.id_group = load_tiles.id_group
#			#	new_tiles.id_tile = load_tiles.id_tile

