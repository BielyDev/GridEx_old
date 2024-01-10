extends Spatial

onready var Anima: AnimationPlayer = $"../Selection3D/Anima"
var Option
var block_pos: Array = []
var mode: int = 0
var delete_select: bool = false


func _ready() -> void:
	yield(get_tree().create_timer(1),"timeout")
	Option.connect("item_selected",self,"mode_selected")


func add_block(pos: Vector3,rot: Vector3,tile_mesh: MeshInstance,undo: bool = true) -> bool:
	match mode:
		0:
			for blocos in get_children():
				if blocos.global_transform.origin == pos:
					blocos.queue_free()
					block_pos.erase(pos)
			
			instance_block(tile_mesh,pos,rot,undo)
		1:
			for pos_array in block_pos:
				if pos_array.pos == pos:
					return false
			
			instance_block(tile_mesh,pos,rot,undo)
		2:
			instance_block(tile_mesh,pos,rot,undo)
		3:
			for blocos in get_children():
				if blocos.global_transform.origin == pos:
					blocos.queue_free()
					block_pos.erase(pos)
					
					instance_block(tile_mesh,pos,rot,undo)
	
	Anima.stop()
	Anima.play("Add")
	
	return true


func remove_block(pos: Vector3,undo: bool = true) -> void:
	
	var tile = loop_get_tile(self,pos,undo)

func delete_block(tile,pos,undo) -> bool:
	var tile_undo
	
	if tile != null:
		tile.queue_free()
		
		if delete_select:
			var dic = {pos = pos,tile = Index.tile.tile}
			block_pos.erase(dic)
		else:
			for block in block_pos:
				if block.pos == pos:
					var dic = {pos = pos,tile = block.tile}
					block_pos.erase(dic)
					tile_undo = block.tile
		
		if undo: Index.undo.append({pos = pos,add = false,tile = tile_undo})
		
		Anima.stop()
		Anima.play("Remove")
		return true
	
	return false


func loop_get_tile(node,pos: Vector3,undo):
	for pos_array in node.get_children():
		if pos_array.get_child_count() >= 1:
			if pos_array is OmniLight:
				if pos_array.global_transform.origin == pos:
					delete_block(pos_array,pos,undo)
			else:
				loop_get_tile(pos_array,pos,undo)
		else:
			if pos_array.global_transform.origin == pos:
				delete_block(pos_array,pos,undo)



func instance_block(tile_mesh: MeshInstance,pos_in: Vector3,rot: Vector3,undo: bool) -> void:
	var tile = tile_mesh.duplicate()
	add_child(tile)
	
	tile.global_transform.origin = pos_in
	tile.rotation_degrees = rot
	
	block_pos.push_back({pos = pos_in, tile = tile})
	
	if undo: Index.undo.append({pos = pos_in,add = true,tile = tile})


func mode_selected(index: int) -> void:
	mode = index

