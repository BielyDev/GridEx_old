extends Button

export(NodePath) var Node_Path: NodePath
export(String) var my_propriety: String
export(String) var his_propriety: String
export(bool) var negative: bool = false

onready var No := get_node_or_null(Node_Path)

func _ready() -> void:
	if No == null:
		yield(get_tree().create_timer(0.5),"timeout")
	apply()

func _pressed() -> void:
	apply()

func apply() -> void:
	if negative:
		No.set(his_propriety,!get(my_propriety))
		return
	
	No.set(his_propriety,get(my_propriety))
