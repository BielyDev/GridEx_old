extends Node

onready var Block: Spatial = $"../Block"
var Worlds = Spatial.new()
var collision_save: Array


func export_scene_gltf(path: String) -> void:
	pass


func export_scene(path: String,collision_enabled: bool,collision_mode: int,light_enabled: bool,mesh_enabled: bool,mesh_mode:int) -> void:
	var scene = PackedScene.new()
	
	add_child(Worlds)
	yield(get_tree().create_timer(0.1),"timeout")
	
	add_block_export()
	yield(get_tree().create_timer(1),"timeout")
	
	if collision_enabled:
		add_collision_export(Worlds,collision_mode)
		yield(get_tree().create_timer(2),"timeout")
	
	if light_enabled == false:
		for child in Worlds.get_children():
			if child.get("light_color") != null:
				child.queue_free()
	
	yield(get_tree().create_timer(1),"timeout")
	
	Worlds.name = "GridEx"
	
	scene.pack(Worlds)
	var error = ResourceSaver.save(path,scene)
	Worlds.queue_free()
	
	collision_save = []


func add_block_export():
	for i in Block.get_children():
		var no = i.duplicate()
		
		Worlds.call("add_child",no)
		
		no = Index.makelocal(no,Worlds)
		
		verific_collision(no)
		delet_others(no)


func add_collision_export(Worlds,collision_mode):
	match collision_mode:
		0:
			var static_collision = StaticBody.new()
			Worlds.call("add_child",static_collision)
			static_collision.name = "Static_Grid"
			static_collision.set_owner(Worlds)
			
			for coll in collision_save.size():
				var collision = CollisionShape.new()
				collision.name = "Collision"
				
				static_collision.call("add_child",collision)
				collision.shape = collision_save[coll].shape
				collision.global_transform.origin = collision_save[coll].pos
				
				collision.set_owner(Worlds)


func delet_others(node):
	node.set_script(null)
	for child in node.get_children():
		child.queue_free()


func verific_collision(node):
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
			verific_collision(node)


