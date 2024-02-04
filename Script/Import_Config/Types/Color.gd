extends ColorPickerButton

var mat
var mat_propriety: String

func _ready() -> void:
	color = mat.get(mat_propriety)

func _on_Color_color_changed(_color: Color) -> void:
	mat.set(mat_propriety,_color)
