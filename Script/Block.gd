extends Spatial

onready var Anima: AnimationPlayer = $"../Selection3D/Anima"
var Option
var block_pos: Array = []
var mode: int = 0
var delete_select: bool = false


func _ready() -> void:
	yield(get_tree().create_timer(1),"timeout")
	Option.connect("item_selected",self,"mode_selected")


func add_block(pos: Vector3,rot: Vector3,item_scene: PackedScene,undo: bool = true) -> bool:
	match mode:
		0:
			for blocos in get_children():
				if blocos.global_transform.origin == pos:
					blocos.queue_free()
					block_pos.erase(pos)
			
			instance_block(item_scene,pos,rot,undo)
		1:
			for pos_array in block_pos:
				if pos_array.pos == pos:
					return false
			
			instance_block(item_scene,pos,rot,undo)
		2:
			instance_block(item_scene,pos,rot,undo)
		3:
			for blocos in get_children():
				if blocos.global_transform.origin == pos:
					blocos.queue_free()
					block_pos.erase(pos)
					
					instance_block(item_scene,pos,rot,undo)
	
	Anima.stop()
	Anima.play("Add")
	
	return true


func remove_block(pos: Vector3,undo: bool = true) -> bool:
	var path_undo 
	for pos_array in get_children():
		if pos_array.global_transform.origin == pos:
			pos_array.queue_free()
			
			if delete_select:
				var dic = {pos = pos,path = Index.tile.path}
				block_pos.erase(dic)
			else:
				for block in block_pos:
					if block.pos == pos:
						var dic = {pos = pos,path = block.path}
						block_pos.erase(dic)
						path_undo = block.path
			
			if undo: Index.undo.append({pos = pos,add = false,path = path_undo})
			
			Anima.stop()
			Anima.play("Remove")
			return true
	
	return false


func instance_block(item_scene: PackedScene,pos_in: Vector3,rot: Vector3,undo: bool) -> void:
	var item_ins = item_scene.instance()
	add_child(item_ins)
	
	item_ins.global_transform.origin = pos_in
	item_ins.rotation_degrees = rot
	
	block_pos.append({pos = pos_in, path = item_scene.resource_path})
	if undo: Index.undo.append({pos = pos_in,add = true,path = item_scene.resource_path})

func mode_selected(index: int) -> void:
	mode = index
