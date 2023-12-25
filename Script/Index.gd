extends Node

signal model_tile_selection(mesh)

enum SETT {CAM_SENSI,CAM_SENSI_MOVE}
enum MODE {ADD,REMOVE}

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

