extends VBoxContainer

onready var x: SpinBox = $X/X
onready var y: SpinBox = $Y/Y
onready var z: SpinBox = $Z/Z

var vector: Vector3

var node
var propriety: String

func _ready() -> void:
	yield(get_tree().create_timer(0.1),"timeout")
	vector = node.get(propriety)
	
	x.value = vector.x
	y.value = vector.y
	z.value = vector.z

func update_vec() -> void:
	vector = node.get(propriety)
	x.value = vector.x
	y.value = vector.y
	z.value = vector.z

func _on_X_value_changed(_value: float) -> void:
	vector.x = _value
	node.set(propriety,vector)
func _on_Y_value_changed(_value: float) -> void:
	vector.y = _value
	node.set(propriety,vector)
func _on_Z_value_changed(_value: float) -> void:
	vector.z = _value
	node.set(propriety,vector)
