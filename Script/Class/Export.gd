extends GridEx

class_name Export

static func export_tscn(path: String,collision_enabled: bool,collision_mode: int,light_enabled: bool,mesh_enabled: bool,mesh_mode:int) -> void:
	#Condigure tree.
	var scene: PackedScene = PackedScene.new()
	var Worlds: Spatial = Spatial.new()
	var collision_save: Array = []
	
	#É preciso um node instanciado para montar a cena.
	Index.add_child(Worlds)
	Worlds.name = "GridEx"
	
	#Montagem---------------------------------------------------------
	add_block_export(Worlds ,collision_save)
	yield(create_time(),"timeout")
	
	if collision_enabled:
		add_collision_export(Worlds ,collision_mode ,collision_save)
	
	system_light(Worlds,light_enabled)
	#-----------------------------------------------------------------
	yield(create_time(),"timeout")
	file_tscn_create(Worlds,collision_save,scene,path)


static func export_scene_gltf(path: String) -> void:
	pass


static func export_new_tiles(Models:Spatial ,path: String ,file: String) -> void:
	for child in Models.get_children():
		var group_scene: PackedScene = PackedScene.new()
		group_scene.pack(child)
		yield(create_time(),"timeout")
		
		print(child)
		file_tile_create(path,child,group_scene)


static func add_block_export(Worlds: Spatial ,collision_save: Array):
	#O Block é onde fica todos os tiles, luzes e colisoes.
	var Block_node: Spatial = Index.edit_node.World3D.Block
	
	loop_get_tile(Block_node,Worlds,collision_save)
	
	for child in Block_node.get_children():
		var new_tile = child.duplicate()
		Worlds.add_child(new_tile)
		new_tile.name = str("Tile_",Worlds.get_child_count())
		
		new_tile = Index.makelocal(new_tile ,Worlds)
		
		verific_collision(new_tile ,collision_save)
		delet_others(new_tile)


static func add_collision_export(Worlds: Spatial ,collision_mode: int ,collision_save: Array):
	match collision_mode:
		0:
			var static_collision = StaticBody.new()
			Worlds.call("add_child",static_collision)
			static_collision.name = "Static_Grid"
			static_collision.set_owner(Worlds)
			
			for coll in collision_save.size():
				var collision = CollisionShape.new()
				collision.name = "Collision"
				
				static_collision.add_child(collision)
				collision.shape = collision_save[coll].shape
				collision.global_transform.origin = collision_save[coll].pos
				
				collision.set_owner(Worlds)


static func system_light(Worlds: Spatial,light_enabled: bool) -> void:
	if light_enabled:
		for lights in Worlds.get_children():
			if lights.get("light_color") != null:
				for spr in lights.get_children():
					spr.queue_free()
	else:
		for lights in Worlds.get_children():
			if lights.get("light_color") != null:
				lights.queue_free()


static func delet_others(node):
	node.set_script(null)
	for child in node.get_children():
		child.queue_free()


static func verific_collision(node,collision_save: Array):
	for child in node.get_children():
		var coll = child.get_child(0)
		
		if is_instance_valid(coll) == false:
			return
		
		var coll_verific = coll.get("shape")
		
		if coll_verific != null:
			collision_save.push_back(
				{
					shape = coll.shape,
					pos = coll.global_transform.origin
				} 
			)
			
			child.queue_free()
		else:
			verific_collision(node,collision_save)


static func loop_get_tile(node,Worlds: Spatial,collision_save: Array):
	for child_0 in node.get_children():
		if child_0.get_child_count() >= 1:
			
			var new_tile = child_0.duplicate()
			Worlds.add_child(new_tile)
			new_tile.name = str("Tile_",Worlds.get_child_count())
			
			new_tile = Index.makelocal(new_tile ,Worlds)
			
			verific_collision(new_tile ,collision_save)
			delet_others(new_tile)
			
			loop_get_tile(child_0,Worlds,collision_save)
		else:
			
			var new_tile = child_0.duplicate()
			Worlds.add_child(new_tile)
			new_tile.name = str("Tile_",Worlds.get_child_count())
			
			new_tile = Index.makelocal(new_tile ,Worlds)
			
			verific_collision(new_tile ,collision_save)
			delet_others(new_tile)


#Todas as funções que criam arquivos =================================================
static func file_tscn_create(Worlds: Spatial,collision_save: Array,scene: PackedScene,path: String) -> void:
	scene.pack(Worlds)
	var error = ResourceSaver.save(path ,scene)
	Worlds.queue_free()
	collision_save = []

static func file_tile_create(path: String,child: Spatial,group_scene: PackedScene) -> void:
	var file_name = str(path,child.name,".tscn")
	var erro = ResourceSaver.save(file_name,group_scene)
	
	yield(create_time(),"timeout")
	Import.import_group_tile_automatic(file_name)
