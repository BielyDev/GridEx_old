extends Node

onready var All: Spatial = $"../All"
onready var Preview: MeshInstance = $"../Selection3D/Preview"
onready var Add: Node = $"../AddBlock"

var path: Array
var inital_pos: Vector3

func create_preview(pos: Vector3) -> void:
	draw_path(inital_pos,pos)
	
	for pos_pre in path:
		var new_pre = Preview.duplicate()
		All.add_child(new_pre)
		
		new_pre.global_transform.origin = pos_pre


func draw_path(point_a: Vector3,point_b: Vector3) -> void:
	
	for child in All.get_children():
		child.queue_free()
	
	var po_a = point_a
	
	path = []
	for distance in int(po_a.distance_to(point_b)):
		po_a = po_a.direction_to(point_b) + po_a
		
		path.push_back(po_a.snapped(Vector3(2,2,2)) - Vector3(0,1,0))
	
	
	for i in range(3):
		var ult_pos: Vector3
		for cam in path:
			if cam == ult_pos:
				path.erase(cam)
			
			ult_pos = cam


func add_block() -> void:
	for pos in path:
		
		Add.add_block_settings(pos)
	
	for child in All.get_children():
		child.queue_free()


func _on_World_move_block(pos: Vector3) -> void:
	if Index.mode == Index.MODE.LINE:
		if Input.is_action_just_pressed("click_left"):
			inital_pos = pos
		if Input.is_action_pressed("click_left"):
			create_preview(pos)
