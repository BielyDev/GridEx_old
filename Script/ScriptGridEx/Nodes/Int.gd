extends GNode

func _ready() -> void:
	value = 0

func _on_int_value_changed(_value: float) -> void:
	self.value = _value
