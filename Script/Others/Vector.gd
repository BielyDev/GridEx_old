extends VBoxContainer

var vector: Vector3

var node
var propriety: String

func _ready() -> void:
	vector = node.get(propriety)

func _on_X_value_changed(_value: float) -> void:
	vector.x = _value
	node.set(propriety,vector)
func _on_Y_value_changed(_value: float) -> void:
	vector.y = _value
	node.set(propriety,vector)
func _on_Z_value_changed(_value: float) -> void:
	vector.z = _value
	node.set(propriety,vector)
