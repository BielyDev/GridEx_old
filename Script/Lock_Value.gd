extends Button

export(NodePath) var Node_Path: NodePath
export(String) var my_propriety: String
export(String) var his_propriety: String

onready var No := get_node(Node_Path)

func _ready() -> void:
	No.set(his_propriety,get(my_propriety))

func _pressed() -> void:
	No.set(his_propriety,get(my_propriety))
