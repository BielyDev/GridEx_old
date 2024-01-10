extends OptionButton

var mat: SpatialMaterial
var mat_propriety: String

func _on_Option_item_selected(_index: int) -> void:
	mat.set(mat_propriety,_index)
