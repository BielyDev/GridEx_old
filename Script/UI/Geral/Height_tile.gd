extends Control

onready var Spin = $Spin

func _ready() -> void:
	Index.connect("height_tile",self,"refresh")
	Index.connect("grid_size",self,"grid_size")

func _on_Spin_value_changed(_value: float) -> void:
	Index.edit_node.World3D.Grid.transform.origin.y = _value

func grid_size(value:Vector3) -> void:
	Spin.step = value.y
	Spin.value = value.y

func refresh(_value: int) -> void:
	Spin.value = _value
