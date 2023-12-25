extends Button

export(NodePath) var Node_Path: NodePath
export(String) var fuction: String

onready var no := get_node(Node_Path)

func _pressed() -> void:
	no.call(fuction)
