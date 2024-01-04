extends HBoxContainer

onready var Pro: PanelContainer = $"../.."

func _on_x_value_changed(_value: float) -> void:
	Pro.tile.rotation_degrees.x = _value

func _on_y_value_changed(_value: float) -> void:
	Pro.tile.rotation_degrees.y = _value

func _on_z_value_changed(_value: float) -> void:
	Pro.tile.rotation_degrees.z = _value
