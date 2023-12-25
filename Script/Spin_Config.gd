extends Control

export(NodePath) var ValueNode_Path: NodePath
export(Index.SETT) var propriety: int

onready var value_node := get_node(ValueNode_Path)

func _ready() -> void:
	Index.settings[propriety] = value_node.value
	
	value_node.connect("value_changed",self,"_change_value")

func _change_value(value: float) -> void:
	Index.settings[propriety] = value
