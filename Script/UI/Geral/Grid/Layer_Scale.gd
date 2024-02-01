extends VBoxContainer

var layer_scale: Vector3 setget layer_scale_set

onready var Vector: VBoxContainer = $Vector

func _ready() -> void:
	Vector.node = self
	Vector.propriety = "layer_scale"
	layer_scale = Vector3(1,1,1)


func layer_scale_set(value: Vector3) -> void:
	for layout in Index.block.get_children():
		for tiles in layout.get_children():
			Index.block.get_child(Index.layer_select).scale = value
	
	layer_scale = value

