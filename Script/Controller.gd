extends Node

onready var Block: Spatial = $"../Block"
onready var Grid: MeshInstance = $"../Grid"
onready var Selection: MeshInstance = $"../Selection3D"
onready var Par: Spatial = $".."

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
			Index.view3d.pos.state = Index.view3d.pos.STATE.BLOCK
			Grid.transform.origin.y += Par.grid_space.y
			Index.emit_signal("height_tile",Grid.transform.origin.y)
		
		elif Input.is_action_just_pressed("middle_down"):
			Index.view3d.pos.state = Index.view3d.pos.STATE.BLOCK
			Grid.transform.origin.y += -Par.grid_space.y
			Index.emit_signal("height_tile",Grid.transform.origin.y)
		
		else:
			Index.view3d.pos.state = Index.view3d.pos.STATE.IDLE


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
	if Input.is_action_just_pressed("rot_y"):
		rot.y += 90
	if Input.is_action_just_pressed("rot_z"):
		rot.z += 90
	
	if Index.snapped.rot:
		rot = rot.snapped(Vector3(90,90,90))
	else:
		rot = rot
	
	Selection.rotation_degrees = rot

