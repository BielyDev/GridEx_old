extends Spatial


onready var Grid: MeshInstance = $Grid
onready var Selection: MeshInstance = $Selection3D
onready var View := get_node(View_path)
onready var Block: Spatial = $Block
onready var Tw: Tween = $Tween

export(int) var grid_size: int
export(NodePath) var View_path: NodePath

var pos: Vector3 
var rot: Vector3


func _input(event: InputEvent) -> void:
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
						Block.add_block(pos,load(Index.tile.path))
				Index.MODE.REMOVE:
					Block.remove_block(pos)
	
	
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
	if View.get_local_mouse_position().x >= View.get_child(0).size.x or View.get_local_mouse_position().x <= 80:
		return false
	if View.get_local_mouse_position().y >= View.get_child(0).size.y or View.get_local_mouse_position().y <= 80:
		return false
	return true


func export_scene_gltf() -> void:
	var scenegltf = PackedSceneGLTF.new()
	
	scenegltf.export_gltf(
		Block,
		str(
			OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS),"/model.gltf"
		)
	)


func export_scene() -> void:
	var scene = PackedScene.new()
	
	
	var result = scene.pack(Block)
	
	if result == OK:
		var error = ResourceSaver.save(str(OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS),"/model.tscn"),scene)
