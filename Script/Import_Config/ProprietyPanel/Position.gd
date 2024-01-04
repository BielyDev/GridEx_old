extends HBoxContainer

onready var Pro: PanelContainer = $"../.."

func _on_x_value_changed(_value: float) -> void:
	Pro.tile.global_transform.origin.x = _value

func _on_y_value_changed(_value: float) -> void:
	Pro.tile.global_transform.origin.y = _value

func _on_z_value_changed(_value: float) -> void:
	Pro.tile.global_transform.origin.z = _value
