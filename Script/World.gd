extends Spatial


onready var Grid: MeshInstance = $Grid
onready var Selection: MeshInstance = $Selection3D
onready var View := get_node(View_path)
onready var Block: Spatial = $Block
onready var Tw: Tween = $Tween
onready var Mirror: OptionButton = $"%Mirror"

export(int) var grid_size: int
export(NodePath) var View_path: NodePath

var pos: Vector3 
var rot: Vector3


func _input(event: InputEvent) -> void:
	Selection.visible = Index.mode != Index.MODE.VOID
	
	if Index.block_view:
		return
	
	if event is InputEventMouseMotion:
		var mouse2d = View.get_local_mouse_position() #+ Vector2(-40,0)
		var project = Index.cam.project_position(mouse2d,40)
		
		Index.ray.look_at(project,Vector3.UP)
		
		pos = Index.ray.get_collision_point().snapped(Vector3(2,2,2)) + Vector3(0,1,0)
		Selection.global_transform.origin = pos
	
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		if Input.is_action_pressed("click_left") and verific_mouse():
			match Index.mode:
				Index.MODE.ADD:
					if Index.tile.path != "":
						add_block_settings()
				Index.MODE.REMOVE:
					remove_block_settings()
	
	
	if Input.is_action_just_pressed("rot"):
		rot.y += 90
		
		Selection.rotation_degrees.y = rot.y - 90
		Tw.interpolate_property(Selection,"rotation_degrees:y",Selection.rotation_degrees.y,rot.y,0.5,Tween.TRANS_BACK)
		Tw.start()
	
	if Input.is_action_pressed("speed"):
		if Input.is_action_just_pressed("middle_up"):
			Index.cam.get_parent().state = Index.cam.get_parent().STATE.BLOCK
			Grid.transform.origin.y += 2
		elif Input.is_action_just_pressed("middle_down"):
			Index.cam.get_parent().state = Index.cam.get_parent().STATE.BLOCK
			Grid.transform.origin.y += -2
		else:
			Index.cam.get_parent().state = Index.cam.get_parent().STATE.IDLE


func verific_mouse() -> bool:
	if View.get_local_mouse_position().x >= View.get_child(0).size.x or View.get_local_mouse_position().x <= 45:
		return false
	if View.get_local_mouse_position().y >= View.get_child(0).size.y or View.get_local_mouse_position().y <= 35:
		return false
	return true


func add_block_settings() -> void:
	var path_tile = load(Index.tile.path)
	
	match Mirror.selected:
		0:
			Block.add_block(pos,load(Index.tile.path))
			
		1:
			var pos_mir = Vector3(-pos.x,pos.y,pos.z)
			
			Block.add_block(pos,path_tile)
			Block.add_block(pos_mir,path_tile)
			
		2:
			var pos_mir = Vector3(pos.x,pos.y,-pos.z)
			
			Block.add_block(pos,path_tile)
			Block.add_block(pos_mir,path_tile)
			
		3:
			add_mirror_x_y(path_tile)


func remove_block_settings() -> void:
	match Mirror.selected:
		0:
			Block.remove_block(pos)
			
		1:
			var pos_mir = Vector3(-pos.x,pos.y,pos.z)
			
			Block.remove_block(pos)
			Block.remove_block(pos_mir)
			
		2:
			var pos_mir = Vector3(pos.x,pos.y,-pos.z)
			
			Block.remove_block(pos)
			Block.remove_block(pos_mir)
			
		3:
			remove_mirror_x_y()


func add_mirror_x_y(path_tile) -> void:
	var pos_x_neg = Vector3(-pos.x,pos.y,pos.z)
	var pos_x_z_neg = Vector3(pos.x,pos.y,-pos.z)
	var pos_x_neg_z_neg = Vector3(-pos.x,pos.y,-pos.z)
	
	var pos_z_x = Vector3(pos.z,pos.y,pos.x)
	var pos_z_x_neg = Vector3(pos.z,pos.y,-pos.x)
	var pos_z_neg_x_neg = Vector3(-pos.z,pos.y,-pos.x)
	var pos_z_neg_x = Vector3(-pos.z,pos.y,pos.x)
	
	Block.add_block(pos,path_tile)
	Block.add_block(pos_x_neg,path_tile)
	Block.add_block(pos_x_neg_z_neg,path_tile)
	Block.add_block(pos_x_z_neg,path_tile)
	
	Block.add_block(pos_z_x,path_tile)
	Block.add_block(pos_z_neg_x,path_tile)
	Block.add_block(pos_z_x_neg,path_tile)
	Block.add_block(pos_z_neg_x_neg,path_tile)


func remove_mirror_x_y() -> void:
	var pos_x_neg = Vector3(-pos.x,pos.y,pos.z)
	var pos_x_z_neg = Vector3(pos.x,pos.y,-pos.z)
	var pos_x_neg_z_neg = Vector3(-pos.x,pos.y,-pos.z)
	
	var pos_z_x = Vector3(pos.z,pos.y,pos.x)
	var pos_z_x_neg = Vector3(pos.z,pos.y,-pos.x)
	var pos_z_neg_x_neg = Vector3(-pos.z,pos.y,-pos.x)
	var pos_z_neg_x = Vector3(-pos.z,pos.y,pos.x)
	
	Block.remove_block(pos)
	Block.remove_block(pos_x_neg)
	Block.remove_block(pos_x_neg_z_neg)
	Block.remove_block(pos_x_z_neg)
	
	Block.remove_block(pos_z_x)
	Block.remove_block(pos_z_neg_x)
	Block.remove_block(pos_z_x_neg)
	Block.remove_block(pos_z_neg_x_neg)


func export_scene_gltf(path: String) -> void:
	var scenegltf = PackedSceneGLTF.new()
	
	var no_export = Block.duplicate()
	
	for child in no_export.get_children():
		for childs in child.get_children():
			childs.queue_free()
	
	yield(get_tree().create_timer(1),"timeout")
	
	scenegltf.export_gltf(no_export,path)


func export_scene(path: String) -> void:
	var scene = PackedScene.new()
	var Worlds = Spatial.new()
	
	add_child(Worlds)
	
	for i in Block.get_children():
		var no = i.duplicate()
		
		Worlds.add_child(no)
		
		no = makelocal(no,Worlds)
		
		for child in no.get_children():
			child.queue_free()
	
	yield(get_tree().create_timer(1),"timeout")
	
	Worlds.name = "GridEx"
	
	scene.pack(Worlds)
	var error = ResourceSaver.save(path,scene)
	Worlds.queue_free()

func makelocal(node,owner_node):
	
	node.filename = ""
	node.set_owner(owner_node)
	
	for child in node.get_children():
		child = makelocal(child,owner_node)
	
	return node
