extends VBoxContainer

var layer_position: Vector3 setget layer_position_set

onready var Vector: VBoxContainer = $Vector

func _ready() -> void:
	Vector.node = self
	Vector.propriety = "layer_position"


func layer_position_set(value: Vector3) -> void:
	for layout in Index.block.get_children():
		for tiles in layout.get_children():
			Index.block.get_child(Index.layer_select).transform.origin = value
	
	layer_position = value

