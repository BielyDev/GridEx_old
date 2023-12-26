extends Button

export(NodePath) var Node_Path: NodePath
export(String) var my_propriety: String
export(String) var his_propriety: String

onready var No := get_node(Node_Path)

func _ready() -> void:
	set(my_propriety,No.get(his_propriety))

func _pressed() -> void:
	set(my_propriety,No.get(his_propriety))
