extends MeshInstance

class_name Tile

var id_tile: int = -1
var id_group: int = -1

var started: Vector3

func _ready() -> void:
	started = transform.origin
