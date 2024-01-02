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
var undo: Array = []
var Tw: Tween = Tween.new()

var tile: Dictionary = {
	path = "",
	icon = null,
}
var edit: Dictionary = {
	enabled = false,
	scene_path = "",
	other = null,
}
var settings: Array = [
	0,0,0
]


func _ready() -> void:
	add_child(Tw)


func call_edit():
	var scene = load(edit.scene_path).instance()
	scene.get_child(0).light = edit.other
	add_child(scene)
	scene.get_child(0).sets()

func call_export(scene_path,dir,no,call) -> void:
	var can = CanvasLayer.new()
	add_child(can)
	can.layer = 10
	
	var scene = load(scene_path).instance()
	scene.dir = dir
	can.add_child(scene)
	scene.connect("finished",no,call)

func search_arr_dic(array: Array,pos: int, value):
	for values in array:
		if values.values()[pos] == value:
			return values
	
	return false


func animated_tween_ui(object: Node,propriety: String, value_initial,value_final,time: float = 0.5) -> void:
	Tw.interpolate_property(object,propriety,value_initial,value_final,time,Tween.TRANS_BACK)
	Tw.start()

