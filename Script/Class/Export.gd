extends Node

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
	
	if collision_enabled:
		add_collision_export(Worlds ,collision_mode ,collision_save)
	
	if light_enabled == false:
		for child in Worlds.get_children():
			if child.get("light_color") != null:
				child.queue_free()
	#-----------------------------------------------------------------
	
	scene.pack(Worlds)
	var error = ResourceSaver.save(path ,scene)
	Worlds.queue_free()
	collision_save = []


static func export_scene_gltf(path: String) -> void:
	pass


static func add_block_export(Worlds: Spatial ,collision_save: Array):
	#O Block é onde fica todos os tiles, luzes e colisoes.
	var Block_node: Spatial = Index.edit_node.World3D.Block
	
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

