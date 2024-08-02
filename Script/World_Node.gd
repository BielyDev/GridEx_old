extends Spatial

signal move_block(pos)

onready var View: ViewportContainer = $"../Local/Vbox/Hbox/View/ViewPanel/View"
onready var OptionsBar: PanelContainer = $"../Local/Vbox/Hbox/LeftBar/Options/Options/Options"

onready var Selection: MeshInstance = $Selection3D
onready var Cont: Node = $Controller
onready var Block: Spatial = $Block
onready var Add: Node = $AddBlock
onready var Line: Node = $Line
onready var Grid: MeshInstance = $Grid
onready var Preview: MeshInstance = $Selection3D/Preview
onready var Preview_instance: MeshInstance = $Selection3D/Preview_instance

export(int) var grid_size: int

var button_pressed: bool = false
var selection_visible: bool = true
var selection_instance_visible: bool = false
var pos_save: Vector3 = Vector3(999,99,999)
var pos: Vector3 
var grid_space: Vector3 = Vector3(2,2,2)
var save_line: Vector3
var thread = Thread.new()

func _input(_event: InputEvent) -> void:
	Selection.visible = (Index.mode != Index.MODE.VOID) and Index.block_view == false
	
	Grid.scale = grid_space
	
	Preview.visible = selection_visible and (Index.mode != Index.MODE.LIGHT) and selection_instance_visible == false
	Preview_instance.visible = Preview.visible == false and selection_instance_visible and (Index.mode != Index.MODE.LIGHT)
	
	if Index.block_view:
		return
	
	if (_event is InputEventMouseMotion or _event is InputEventMouseButton):
		#is_action_pressed("click_left")
		button_pressed = Input.is_mouse_button_pressed(1)
		_selection_moviment()
	
	if Input.is_action_just_released("click_left"):
		if Index.mode == Index.MODE.LINE:
			if Input.is_action_just_released("click_left"):
				Line.add_block()
		
		pos_save = Vector3(0,999,0)



func _selection_moviment() -> void:
	var mouse2d = View.get_local_mouse_position() #+ Vector2(-40,0)
	var project: Vector3 = Index.view3d.cam.project_position(mouse2d,40)
	
	if Index.view3d.cam.projection == Camera.PROJECTION_ORTHOGONAL:
		project = Index.view3d.cam.project_position(mouse2d,Index.view3d.cam.size)
	
	Index.view3d.ray.look_at(project,Vector3.UP)
	
	if pos != pos_save:
		if Input.is_mouse_button_pressed(1):
			selection_move()
			pos_save = pos
		
		emit_signal("move_block",pos)
	
	var layer_select =  Index.block.get_child(Index.layer_select)
	var mouse = Index.view3d.ray.get_collision_point().snapped(grid_space)
	var vetor
	
	if layer_select != null:
		vetor = layer_select.transform.origin
		
		var set_vec = Vector3(round(vetor.x),round(vetor.y),round(vetor.z)).snapped(grid_space)
		pos = ((vetor - set_vec) + mouse) * layer_select.scale
		
		Selection.global_transform.origin = pos


func selection_move():
	if button_pressed:
		_start_mode()


func _start_mode() -> void:
	match Index.mode:
		Index.MODE.ADD:
			if Index.tile.id_tile != -1:
				if thread.is_active():
					Add.add_block_settings()
				else:
					thread.start(Add,"add_block_settings")
				
				if IndexLayer.edit.enabled == true:
					IndexLayer.call_edit()
		
		Index.MODE.REMOVE:
			Add.remove_block_settings()
		
		Index.MODE.LIGHT:
			Add.add_light()


func verific_mouse() -> bool:
	if View.get_local_mouse_position().x >= View.get_child(0).size.x or View.get_local_mouse_position().x <= 45:
		return false
	if View.get_local_mouse_position().y >= View.get_child(0).size.y or View.get_local_mouse_position().y <= 35:
		return false
	return true

