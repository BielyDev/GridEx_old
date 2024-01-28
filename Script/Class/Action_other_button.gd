extends AnimationButtonClass

class_name Action_other_button

export(NodePath) var Node_path: NodePath

onready var no := get_node(Node_path)


func _pressed() -> void:
	no.get_popup().popup(Rect2(get_global_mouse_position(),Vector2(100,40)))
