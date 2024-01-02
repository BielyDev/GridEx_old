extends CanvasLayer

var popup_pc_new: PackedScene = preload("res://Scene/Popups/Popup_PC.tscn")
var file_explore_new: PackedScene = preload("res://Scene/Popups/File_explore.tscn")



var edit: Dictionary = {
	enabled = false,
	scene_path = "",
	other = null,
}

func warning_pc(text: String,object: Node,OK: String,CANCEL: String) -> void:
	var pop = popup_pc_new.instance()
	
	pop.text = text
	pop.connect("CANCEL",object,CANCEL)
	pop.connect("OK",object,OK)
	
	add_child(pop)


func call_edit():
	var scene = load(edit.scene_path).instance()
	scene.get_child(0).light = edit.other
	add_child(scene)
	scene.get_child(0).sets()


func call_export(scene_path,dir,no,call) -> void:
	var scene = load(scene_path).instance()
	scene.dir = dir
	add_child(scene)
	scene.connect("finished",no,call)


func file_explore(files : Array,object: Node,OK: String,CANCEL: String) -> void:
	var explore = file_explore_new.instance()
	
	explore.files = files
	explore.connect("CANCEL",object,CANCEL)
	explore.connect("OK",object,OK)
	
	add_child(explore)
