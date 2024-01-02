extends Node

var View
var Mirror

onready var Selection: MeshInstance = $Selection3D
onready var Tw: Tween = $Tween
onready var Cont: Node = $Controller
onready var Block: Spatial = $Block
onready var Add: Node = $AddBlock
onready var Export: Node = $Export


export(int) var grid_size: int

var button_pressed: bool = false
var pos_save: Vector3 = Vector3(999,99,999)
var pos: Vector3 


func _input(event: InputEvent) -> void:
	
	Selection.visible = (Index.mode != Index.MODE.VOID) and Index.block_view == false
	
	if Index.block_view:
		return
	
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		
		button_pressed = Input.is_action_pressed("click_left")
		_selection_moviment()
	
	if Input.is_action_just_released("click_left"):
		pos_save = Vector3(0,999,0)

func _selection_moviment() -> void:
	var mouse2d = View.get_local_mouse_position() #+ Vector2(-40,0)
	var project = Index.cam.project_position(mouse2d,40)
	
	Index.ray.look_at(project,Vector3.UP)
	
	if Input.is_action_pressed("click_left") and pos != pos_save:
		selection_move()
		pos_save = pos
	pos = Index.ray.get_collision_point().snapped(Vector3(2,2,2)) + Vector3(0,1,0)
	
	Selection.global_transform.origin = pos


func selection_move():
	if button_pressed:
		_add_block()


func _add_block() -> void:
	match Index.mode:
		Index.MODE.ADD:
			if Index.tile.path != "":
				add_block_settings()
				if Index.edit.enabled == true:
					Index.call_edit()
		Index.MODE.REMOVE:
			Add.remove_block_settings()


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
			Cont.Block.add_block(pos,Cont.rot,load(Index.tile.path))
			
		1:
			var pos_mir = Vector3(-pos.x,pos.y,pos.z)
			var rot_mir = Vector3(Cont.rot.x,-Cont.rot.y,Cont.rot.z)
			
			Cont.Block.add_block(pos,Cont.rot,path_tile)
			Cont.Block.add_block(pos_mir,rot_mir,path_tile)
			
		2:
			var pos_mir = Vector3(pos.x,pos.y,-pos.z)
			var rot_mir = Vector3(Cont.rot.x,-Cont.rot.y+180,Cont.rot.z)
			
			Cont.Block.add_block(pos,Cont.rot,path_tile)
			Cont.Block.add_block(pos_mir,rot_mir,path_tile)
			
		3:
			Add.add_mirror_x_y(path_tile)
