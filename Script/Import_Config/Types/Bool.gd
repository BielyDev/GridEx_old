extends CheckBox

var mat: SpatialMaterial
var mat_propriety: String

func _pressed() -> void:
	mat.set(mat_propriety,pressed)
