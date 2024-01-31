extends VBoxContainer

var layout_space: Vector3 setget global_space_set

onready var Vector: VBoxContainer = $Vector
onready var Grid_space: VBoxContainer = $"../../PanelGrid_Space/Grid_Space"
onready var VectorGrid: VBoxContainer = $"../../PanelGrid_Space/Grid_Space/Vector"

func _ready() -> void:
	Vector.node = self
	Vector.propriety = "layout_space"
	layout_space = Vector3(2,2,2)


func global_space_set(value: Vector3) -> void:
	if Index.block.get_children().size() == 0:
		return
	for tiles in Index.block.get_child(Index.layer_select).get_children():
		var tile_pos = tiles.transform.origin
		if layout_space.x != 0:
			tile_pos.x = value.x * (tile_pos.x/layout_space.x)
		else:
			tile_pos.x = 0
		
		if layout_space.y != 0:
			tile_pos.y = value.y * (tile_pos.y/layout_space.y)
		else:
			tile_pos.y = 0
		
		if layout_space.z != 0:
			tile_pos.z = value.z * (tile_pos.z/layout_space.z)
		else:
			tile_pos.z = 0
		
		tiles.transform.origin = tile_pos
	
	Grid_space.grid_space = value
	VectorGrid.update_vec()
	layout_space = value

