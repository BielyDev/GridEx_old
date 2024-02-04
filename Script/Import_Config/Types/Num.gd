extends HSlider

var mat
var mat_propriety: String

func _ready() -> void:
	set_deferred("value",mat.get(mat_propriety))

func _on_Num_value_changed(_value: float) -> void:
	mat.set(mat_propriety,_value)
