extends ColorPickerButton

export(NodePath) var Node_Path: NodePath
export(String) var his_propriety: String

onready var No := get_node_or_null(Node_Path)

func _ready() -> void:
	if No == null:
		yield(get_tree().create_timer(0.5),"timeout")
	No.set(his_propriety,color)
	connect("color_changed",self,"event")

func event(_cor: Color) -> void:
	No.set(his_propriety,_cor)
