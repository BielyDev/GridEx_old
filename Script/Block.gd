extends Spatial

onready var Anima: AnimationPlayer = $"../Selection3D/Anima"

var block_pos: Array = []

func add_block(pos: Vector3,item_scene: PackedScene) -> bool:
	for pos_array in block_pos:
		if pos_array == pos:
			return false
	
	var item_ins = item_scene.instance()
	add_child(item_ins)
	item_ins.global_transform.origin = pos
	item_ins.rotation_degrees = get_parent().rot
	block_pos.append(pos)
	set_owner(item_ins)
	
	Anima.stop()
	Anima.play("Add")
	
	return true


func remove_block(pos: Vector3) -> bool:
	for pos_array in get_children():
		if pos_array.global_transform.origin == pos:
			pos_array.queue_free()
			block_pos.erase(pos)
			
			Anima.stop()
			Anima.play("Remove")
			return true
	
	return false

