extends Spatial

onready var Anima: AnimationPlayer = $"../Selection3D/Anima"
onready var Option: OptionButton = $"%Option"

var block_pos: Array = []
var mode: int = 0


func _ready() -> void:
	Option.connect("item_selected",self,"mode_selected")


func add_block(pos: Vector3,item_scene: PackedScene) -> bool:
	match mode:
		0:
			for blocos in get_children():
				if blocos.global_transform.origin == pos:
					blocos.queue_free()
					block_pos.erase(pos)
			
			instance_block(item_scene,pos)
		1:
			for pos_array in block_pos:
				if pos_array == pos:
					return false
			
			instance_block(item_scene,pos)
		2:
			instance_block(item_scene,pos)
		3:
			for blocos in get_children():
				if blocos.global_transform.origin == pos:
					blocos.queue_free()
					block_pos.erase(pos)
					
					instance_block(item_scene,pos)
	
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


func instance_block(item_scene,pos) -> void:
	var item_ins = item_scene.instance()
	add_child(item_ins)
	
	item_ins.global_transform.origin = pos
	item_ins.rotation_degrees = get_parent().rot
	block_pos.append(pos)

func mode_selected(index: int) -> void:
	mode = index
