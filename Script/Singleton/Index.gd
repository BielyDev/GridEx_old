extends Node

signal model_tile_selection(mesh)
signal change_tile()
signal height_tile(height)

enum SETT {CAM_SENSI,CAM_SENSI_MOVE}
enum MODE {VOID,ADD,REMOVE,LINE,BUCKET,LIGHT}

var block_view: bool = false
var edit_node
var block
var mode
var layer_select: int
var cam: Camera
var ray: RayCast
var env : Environment = preload("res://default_env.tres")
var undo: Array = []

var tile: Dictionary = {
	id_tile = -1,
	id_group = -1,
	icon = null,
}

var settings: Array = [
	50,50,50
]


func open_project(dir: String) -> void:
	get_tree().reload_current_scene()
	yield(get_tree().create_timer(0.3),"timeout")
	
	for groups in edit_node.Tile_groups.get_children():
		groups.queue_free()
	
	yield(get_tree().create_timer(0.5),"timeout")
	
	edit_node.Layer_panel.Layers.get_child(0).queue_free()
	for layers in block.get_children():
		layers.queue_free()
	
	yield(get_tree().create_timer(0.5),"timeout")
	Save.open_project(dir)


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

