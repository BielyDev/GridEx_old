extends Control

func _on_Spin_value_changed(_value: float) -> void:
	Index.edit_node.World3D.Grid.transform.origin.y = _value
