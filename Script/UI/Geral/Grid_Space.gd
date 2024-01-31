extends VBoxContainer

var grid_space: Vector3 setget grid_space_set

onready var Vector: VBoxContainer = $Vector
onready var Layout_space: VBoxContainer = $"../../PanelLayout_space/Layout_space"

func _ready() -> void:
	Vector.node = self
	Vector.propriety = "grid_space"
	grid_space = Vector3(2,2,2)


func grid_space_set(value: Vector3) -> void:
	grid_space = value
	Index.edit_node.World3D.grid_space = grid_space
	Index.emit_signal("grid_size",grid_space)
	#Layout_space.layout_space = grid_space
