extends GNode

onready var vector_node: VBoxContainer = $Panel/Vector

var vector: Vector3 = Vector3() setget _vector

func _ready() -> void:
	vector_node.node = self
	vector_node.propriety = "vector"
	
	value = vector

func _vector(_value) -> void:
	vector = _value
	
	self.value = vector
