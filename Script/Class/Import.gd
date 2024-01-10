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


static func import_group_tile_automatic(path: String) -> void:
	var tile_menu: PackedScene = preload("res://Scene/Theme_Tile/Basic.tscn")
	
	var scene = load(path)
	var no = scene.instance()
	
	var basic = tile_menu.instance()
	
	basic.tittle = no.name
	basic.group_scene = scene
	Index.edit_node.Tile_groups.add_child(basic)
