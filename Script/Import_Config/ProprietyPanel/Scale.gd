extends HBoxContainer

onready var Pro: PanelContainer = $"../.."

func _on_x_value_changed(_value: float) -> void:
	Pro.tile.scale.x = _value

func _on_y_value_changed(_value: float) -> void:
	Pro.tile.scale.y = _value

func _on_z_value_changed(_value: float) -> void:
	Pro.tile.scale.z = _value
