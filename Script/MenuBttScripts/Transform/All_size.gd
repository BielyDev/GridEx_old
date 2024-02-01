extends Node

signal finished()

var propriety = preload("res://Scene/Popups/Propriety_sped.tscn")

var size: Vector3 = Vector3(1,1,1)

func start() -> void:
	
	var new_p = propriety.instance()
	new_p.node = self
	new_p.Type = new_p.TYPE.VECTOR
	new_p.call_func = "confirm"
	new_p.Propriety_name = "size"
	
	add_child(new_p)

func confirm() -> void:
	for groups in get_parent().get_parent().Models.get_children():
		for childs in groups.get_children():
			childs.scale = size
	
	emit_signal("finished")

