extends Node

onready var Block: Spatial = $"../Block"
onready var Grid: MeshInstance = $"../Grid"
onready var Selection: MeshInstance = $"../Selection3D"

var rot: Vector3


func _input(_event: InputEvent) -> void:
	_others_buttons()
	
	if Index.block_view:
		return
	
	if Input.is_action_pressed("undo"):
		_undo()
		return
	
	_rotation_selection()
	
	if Input.is_key_pressed(KEY_CONTROL):
		if Input.is_action_just_pressed("middle_up"):
			Index.cam.get_parent().state = Index.cam.get_parent().STATE.BLOCK
			Grid.transform.origin.y += 2
			Index.emit_signal("height_tile",Grid.transform.origin.y)
		
		elif Input.is_action_just_pressed("middle_down"):
			Index.cam.get_parent().state = Index.cam.get_parent().STATE.BLOCK
			Grid.transform.origin.y += -2
			Index.emit_signal("height_tile",Grid.transform.origin.y)
		
		else:
			Index.cam.get_parent().state = Index.cam.get_parent().STATE.IDLE


func _others_buttons() -> void:
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen


func _undo() -> void:
	if Index.undo.size() >= 1:
		var id = Index.undo[Index.undo.size()-1]
		
		if id.add == true:
			Block.remove_block(id.pos,false)
		else:
			Block.add_block(id.pos,id.tile,false)
		
		Index.undo.erase(id)



func _rotation_selection() -> void:
	if Input.is_action_just_pressed("rot_x"):
		rot.x += 90
		Selection.rotation_degrees.x = rot.x
	if Input.is_action_just_pressed("rot_y"):
		rot.y += 90
		Selection.rotation_degrees.y = rot.y
	if Input.is_action_just_pressed("rot_z"):
		rot.z += 90
		Selection.rotation_degrees.z = rot.z

