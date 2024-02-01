extends Node

onready var Block: Spatial = $"../Block"
onready var Par := get_parent()
onready var Cont: Node = $"../Controller"

var pos
var Mirror: OptionButton
var Rotation: OptionButton
var Rand: OptionButton
var Light_new: PackedScene = preload("res://Scene/Tiles/Light.tscn")


func _process(_delta: float) -> void:
	pos = Par.pos
	#Cont.


func add_block_settings(pre_pos = pos) -> void:
	var id_tile = Index.tile.id_tile
	
	if id_tile != -1:
		verific_mirror(pre_pos,id_tile)
		verific_random_rotation()

func verific_mirror(pre_pos: Vector3,id_tile: int):
	match Mirror.selected:
		0:
			Block.add_block(pre_pos,Cont.rot,id_tile)
			
		1:
			var pos_mir = Vector3(-pre_pos.x,pre_pos.y,pre_pos.z)
			var rot_mir = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
			
			Block.add_block(pre_pos,Cont.rot,id_tile)
			Block.add_block(pos_mir,rot_mir,id_tile)
			
		2:
			var pos_mir = Vector3(pre_pos.x,pre_pos.y,-pre_pos.z)
			var rot_mir = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
			
			Block.add_block(pre_pos,Cont.rot,id_tile)
			Block.add_block(pos_mir,rot_mir,id_tile)
			
		3:
			add_mirror_x_y(pre_pos,id_tile)


func verific_random_rotation() -> void:
	match Rand.selected:
		1:
			Cont.rot.x = rand_range(0,360)
		2:
			Cont.rot.y = rand_range(0,360)
		3:
			Cont.rot.z = rand_range(0,360)
		4:
			Cont.rot.x = rand_range(0,360)
			Cont.rot.y = rand_range(0,360)
			Cont.rot.z = rand_range(0,360)
	
	Cont._rotation_selection()


func add_mirror_x_y(pre_pos: Vector3,id_tile: int) -> void:
	var pos_x_neg = Vector3(-pre_pos.x,pre_pos.y,pre_pos.z)
	var pos_x_z_neg = Vector3(pre_pos.x,pre_pos.y,-pre_pos.z)
	var pos_x_neg_z_neg = Vector3(-pre_pos.x,pre_pos.y,-pre_pos.z)
	
	var pos_z_x = Vector3(pre_pos.z,pre_pos.y,pre_pos.x)
	var pos_z_x_neg = Vector3(pre_pos.z,pre_pos.y,-pre_pos.x)
	var pos_z_neg_x_neg = Vector3(-pre_pos.z,pre_pos.y,-pre_pos.x)
	var pos_z_neg_x = Vector3(-pre_pos.z,pre_pos.y,pre_pos.x)
	
	var rot_x_neg
	var rot_x_z_neg
	var rot_x_neg_z_neg
	var rot_z_x
	var rot_z_x_neg
	var rot_z_neg_x_neg
	var rot_z_neg_x
	
	match Rotation.selected:
		0:
			rot_x_neg = Cont.rot
			rot_x_z_neg = Cont.rot
			rot_x_neg_z_neg = Cont.rot
			rot_z_x = Cont.rot
			rot_z_x_neg = Cont.rot
			rot_z_neg_x_neg = Cont.rot
			rot_z_neg_x = Cont.rot
		1:
			rot_x_neg = Vector3(Cont.rot.x,-Cont.rot.y-90,Cont.rot.z)
			rot_x_z_neg = Vector3(Cont.rot.x,-Cont.rot.y+90,Cont.rot.z)
			rot_x_neg_z_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
			
			rot_z_x = Vector3(Cont.rot.x,Cont.rot.y,Cont.rot.z)
			
			rot_z_x_neg = Vector3(Cont.rot.x,-Cont.rot.y+90,Cont.rot.z)
			rot_z_neg_x_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
			rot_z_neg_x = Vector3(Cont.rot.x,-Cont.rot.y-90,Cont.rot.z)
		2:
			rot_x_neg = Vector3(Cont.rot.x,-Cont.rot.y,Cont.rot.z)
			rot_x_z_neg = Vector3(Cont.rot.x,-Cont.rot.y+180,Cont.rot.z)
			rot_x_neg_z_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
			
			rot_z_x = Vector3(Cont.rot.x,Cont.rot.y,Cont.rot.z)
			
			rot_z_x_neg = Vector3(Cont.rot.x,-Cont.rot.y+180,Cont.rot.z)
			rot_z_neg_x_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
			rot_z_neg_x = Vector3(Cont.rot.x,-Cont.rot.y,Cont.rot.z)
		3:
			rot_x_neg = Vector3(Cont.rot.x,Cont.rot.y+270,Cont.rot.z)
			rot_x_z_neg = Vector3(Cont.rot.x,Cont.rot.y+270,Cont.rot.z)
			rot_x_neg_z_neg = Vector3(Cont.rot.x,Cont.rot.y,Cont.rot.z)
			
			rot_z_x = Vector3(Cont.rot.x,Cont.rot.y+90,Cont.rot.z)
			
			rot_z_x_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
			rot_z_neg_x_neg = Vector3(Cont.rot.x,Cont.rot.y+90,Cont.rot.z)
			rot_z_neg_x = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
		4:
			rot_x_neg = Vector3(Cont.rot.x,-Cont.rot.y-180,Cont.rot.z)
			rot_x_z_neg = Vector3(Cont.rot.x,-Cont.rot.y+90,Cont.rot.z)
			rot_x_neg_z_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
			
			rot_z_x = Vector3(Cont.rot.x,Cont.rot.y,Cont.rot.z)
			
			rot_z_x_neg = Vector3(Cont.rot.x,-Cont.rot.y+180,Cont.rot.z)
			rot_z_neg_x_neg = Vector3(Cont.rot.x,Cont.rot.y+180,Cont.rot.z)
			rot_z_neg_x = Vector3(Cont.rot.x,-Cont.rot.y,Cont.rot.z)
	
	
	Block.add_block(pre_pos,Cont.rot,id_tile)
	Block.add_block(pos_x_neg,rot_x_neg,id_tile)
	Block.add_block(pos_x_neg_z_neg,rot_x_neg_z_neg,id_tile)
	Block.add_block(pos_x_z_neg,rot_x_z_neg,id_tile)
	
	Block.add_block(pos_z_x,rot_z_x,id_tile)
	Block.add_block(pos_z_neg_x,rot_z_neg_x,id_tile)
	Block.add_block(pos_z_x_neg,rot_z_x_neg,id_tile)
	Block.add_block(pos_z_neg_x_neg,rot_z_neg_x_neg,id_tile)


func add_light() -> void:
	var LightConfig = Light_new.instance()
	Block.get_child(Index.layer_select).add_child(LightConfig)
	LightConfig.global_transform.origin = pos
	
	IndexLayer.light_panel(LightConfig)


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

