extends Node

onready var Block: Spatial = $"../Block"
onready var Par := get_parent()
onready var Cont: Node = $"../Controller"

var Light_new: PackedScene = preload("res://Scene/Tiles/Light.tscn")
var pos

func _process(_delta: float) -> void:
	pos = Par.pos

func add_block_settings(pre_pos = pos) -> void:
	var tile = Index.tile.tile
	
	verific_mirror(pre_pos,tile)

func verific_mirror(pre_pos: Vector3,tile):
	match Par.Mirror.selected:
		0:
			Cont.Block.add_block(pre_pos,Cont.rot,tile)
			
		1:
			var pos_mir = Vector3(-pre_pos.x,pre_pos.y,pre_pos.z)
			var rot_mir = Vector3(Cont.rot.x,-Cont.rot.y,Cont.rot.z)
			
			Cont.Block.add_block(pre_pos,Cont.rot,tile)
			Cont.Block.add_block(pos_mir,rot_mir,tile)
			
		2:
			var pos_mir = Vector3(pre_pos.x,pre_pos.y,-pre_pos.z)
			var rot_mir = Vector3(Cont.rot.x,-Cont.rot.y+180,Cont.rot.z)
			
			Cont.Block.add_block(pre_pos,Cont.rot,tile)
			Cont.Block.add_block(pos_mir,rot_mir,tile)
			
		3:
			add_mirror_x_y(pre_pos,tile)


func add_mirror_x_y(pre_pos: Vector3,tile: MeshInstance) -> void:
	var pos_x_neg = Vector3(-pre_pos.x,pre_pos.y,pre_pos.z)
	var pos_x_z_neg = Vector3(pre_pos.x,pre_pos.y,-pre_pos.z)
	var pos_x_neg_z_neg = Vector3(-pre_pos.x,pre_pos.y,-pre_pos.z)
	
	var pos_z_x = Vector3(pre_pos.z,pre_pos.y,pre_pos.x)
	var pos_z_x_neg = Vector3(pre_pos.z,pre_pos.y,-pre_pos.x)
	var pos_z_neg_x_neg = Vector3(-pre_pos.z,pre_pos.y,-pre_pos.x)
	var pos_z_neg_x = Vector3(-pre_pos.z,pre_pos.y,pre_pos.x)
	
	var rot_x_neg = Vector3(Cont.rot.x,-Cont.rot.y,Cont.rot.z)
	var rot_x_z_neg = Vector3(Cont.rot.x,-Cont.rot.y+180,Cont.rot.z)
	var rot_x_neg_z_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
	
	var rot_z_x = Vector3(Cont.rot.x,Cont.rot.y,Cont.rot.z)
	
	var rot_z_x_neg = Vector3(Cont.rot.x,-Cont.rot.y+180,Cont.rot.z)
	var rot_z_neg_x_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
	var rot_z_neg_x = Vector3(Cont.rot.x,-Cont.rot.y,Cont.rot.z)
	
	Cont.Block.add_block(pre_pos,Cont.rot,tile)
	Cont.Block.add_block(pos_x_neg,rot_x_neg,tile)
	Cont.Block.add_block(pos_x_neg_z_neg,rot_x_neg_z_neg,tile)
	Cont.Block.add_block(pos_x_z_neg,rot_x_z_neg,tile)
	
	Cont.Block.add_block(pos_z_x,rot_z_x,tile)
	Cont.Block.add_block(pos_z_neg_x,rot_z_neg_x,tile)
	Cont.Block.add_block(pos_z_x_neg,rot_z_x_neg,tile)
	Cont.Block.add_block(pos_z_neg_x_neg,rot_z_neg_x_neg,tile)


func add_light() -> void:
	var LightConfig = Light_new.instance()
	Block.add_child(LightConfig)
	LightConfig.global_transform.origin = pos
	
	IndexLayer.light_panel(LightConfig)


func remove_block_settings() -> void:
	match get_parent().Mirror.selected:
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

