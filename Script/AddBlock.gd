extends Node

onready var Block: Spatial = $"../Block"
onready var Par := get_parent()
onready var Cont: Node = $"../Controller"
var pos

func _process(delta: float) -> void:
	pos = Par.pos


func remove_block_settings() -> void:
	match get_parent().Mirror.selected:
		0:
			Block.remove_block(Par.pos)
			
		1:
			var pos_mir = Vector3(-Par.pos.x,Par.pos.y,Par.pos.z)
			
			Block.remove_block(Par.pos)
			Block.remove_block(pos_mir)
			
		2:
			var pos_mir = Vector3(Par.pos.x,Par.pos.y,-Par.pos.z)
			
			Block.remove_block(Par.pos)
			Block.remove_block(pos_mir)
			
		3:
			remove_mirror_x_y()


func add_mirror_x_y(path_tile) -> void:
	var pos_x_neg = Vector3(-Par.pos.x,Par.pos.y,Par.pos.z)
	var pos_x_z_neg = Vector3(Par.pos.x,Par.pos.y,-Par.pos.z)
	var pos_x_neg_z_neg = Vector3(-Par.pos.x,Par.pos.y,-Par.pos.z)
	
	var pos_z_x = Vector3(Par.pos.z,Par.pos.y,Par.pos.x)
	var pos_z_x_neg = Vector3(Par.pos.z,Par.pos.y,-Par.pos.x)
	var pos_z_neg_x_neg = Vector3(-Par.pos.z,Par.pos.y,-Par.pos.x)
	var pos_z_neg_x = Vector3(-Par.pos.z,Par.pos.y,Par.pos.x)
	
	var rot_x_neg = Vector3(Cont.rot.x,-Cont.rot.y,Cont.rot.z)
	var rot_x_z_neg = Vector3(Cont.rot.x,-Cont.rot.y+180,Cont.rot.z)
	var rot_x_neg_z_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
	
	var rot_z_x = Vector3(Cont.rot.x,Cont.rot.y,Cont.rot.z)
	
	var rot_z_x_neg = Vector3(Cont.rot.x,-Cont.rot.y+180,Cont.rot.z)
	var rot_z_neg_x_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
	var rot_z_neg_x = Vector3(Cont.rot.x,-Cont.rot.y,Cont.rot.z)
	
	Cont.Block.add_block(pos,Cont.rot,path_tile)
	Cont.Block.add_block(pos_x_neg,rot_x_neg,path_tile)
	Cont.Block.add_block(pos_x_neg_z_neg,rot_x_neg_z_neg,path_tile)
	Cont.Block.add_block(pos_x_z_neg,rot_x_z_neg,path_tile)
	
	Cont.Block.add_block(pos_z_x,rot_z_x,path_tile) #av
	Cont.Block.add_block(pos_z_neg_x,rot_z_neg_x,path_tile)
	Cont.Block.add_block(pos_z_x_neg,rot_z_x_neg,path_tile)
	Cont.Block.add_block(pos_z_neg_x_neg,rot_z_neg_x_neg,path_tile)


func remove_mirror_x_y() -> void:
	var pos_x_neg = Vector3(-pos.x,pos.y,pos.z)
	var pos_x_z_neg = Vector3(pos.x,pos.y,-pos.z)
	var pos_x_neg_z_neg = Vector3(-pos.x,pos.y,-pos.z)
	
	var pos_z_x = Vector3(pos.z,pos.y,pos.x)
	var pos_z_x_neg = Vector3(pos.z,pos.y,-pos.x)
	var pos_z_neg_x_neg = Vector3(-pos.z,pos.y,-pos.x)
	var pos_z_neg_x = Vector3(-pos.z,pos.y,pos.x)
	
	Cont.Block.remove_block(pos)
	Cont.Block.remove_block(pos_x_neg)
	Cont.Block.remove_block(pos_x_neg_z_neg)
	Cont.Block.remove_block(pos_x_z_neg)
	
	Cont.Block.remove_block(pos_z_x)
	Cont.Block.remove_block(pos_z_neg_x)
	Cont.Block.remove_block(pos_z_x_neg)
	Cont.Block.remove_block(pos_z_neg_x_neg)
