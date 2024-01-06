extends Node

signal model_tile_selection(mesh)
signal change_tile()

enum SETT {CAM_SENSI,CAM_SENSI_MOVE}
enum MODE {VOID,ADD,REMOVE,LINE,BUCKET,LIGHT}

var block_view: bool = false
var edit_node
var mode
var cam: Camera
var ray: RayCast
var env : Environment = preload("res://default_env.tres")
var undo: Array = []

var tile: Dictionary = {
	tile = null,
	icon = null,
}

var settings: Array = [
	50,50,50
]


func search_arr_dic(array: Array,pos: int, value):
	for values in array:
		if values.values()[pos] == value:
			return values
	
	return false


func makelocal(node,owner_node):
	node.filename = ""
	node.set_owner(owner_node)
	
	for child in node.get_children():
		child = makelocal(child,owner_node)
	
	return node

