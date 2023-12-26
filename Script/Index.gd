extends Node

signal model_tile_selection(mesh)
signal change_tile()

enum SETT {CAM_SENSI,CAM_SENSI_MOVE}
enum MODE {VOID,ADD,REMOVE}

var block_view: bool = false
var edit_node
var mode
var cam: Camera
var ray: RayCast
var env : Environment = preload("res://default_env.tres")

var tile: Dictionary = {
	path = "",
	icon = null,
}
var settings: Array = [
	0,0,0
]

