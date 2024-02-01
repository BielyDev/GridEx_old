extends Control

export(NodePath) var ValueNode_Path: NodePath
export(int,"CAM_SENSI","CAM_SENSI_MOVE") var propriety: int

onready var value_node := get_node(ValueNode_Path)
onready var Save_node: Node = $"%Save"

func _ready() -> void:
	value_node.value = Index.settings[propriety]
	
	value_node.connect("value_changed",self,"_change_value")

func _change_value(value: float) -> void:
	Index.settings[propriety] = value
	Save_node.settings[propriety] = value
