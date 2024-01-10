extends CanvasLayer

var popup_two_new: PackedScene = preload("res://Scene/Popups/Popup_PC.tscn")
var popup_one_new: PackedScene = preload("res://Scene/Popups/Popup_OK.tscn")
var file_explore_new: PackedScene = preload("res://Scene/Popups/File_explore.tscn")
var importer_new: PackedScene = preload("res://Scene/Import/Import_Config.tscn")
var light_panel_new: PackedScene = preload("res://Scene/Popups/Light_Control.tscn")

var edit: Dictionary = {
	enabled = false,
	scene_path = "",
	other = null,
}

func popup_two(text: String,object: Node,OK: String,CANCEL: String) -> void:
	var pop = popup_two_new.instance()
	
	pop.text = text
	pop.connect("CANCEL",object,CANCEL)
	pop.connect("OK",object,OK)
	
	add_child(pop)

func popup_one(text: String,object: Node = null,OK: String = "") -> void:
	var pop = popup_one_new.instance()
	
	pop.text = text
	
	if object != null:
		pop.connect("OK",object,OK)
	
	add_child(pop)

func importer_menu(object: Node,OK: String) -> void:
	var importer = importer_new.instance()
	
	add_child(importer)
	importer.connect("OK",object,OK)


func light_panel(light: OmniLight) -> void:
	var li = light_panel_new.instance()
	li.LightConfig = light
	add_child(li)


func call_export(scene_path,dir,no,call) -> void:
	var scene = load(scene_path).instance()
	scene.dir = dir
	add_child(scene)
	scene.connect("finished",no,call)


func file_explore(files : Array,object: Node,OK: String,CANCEL: String, mode = FileDialog.MODE_SAVE_FILE) -> void:
	var explore = file_explore_new.instance()
	
	explore.files = files
	explore.connect("CANCEL",object,CANCEL)
	explore.connect("OK",object,OK)
	
	add_child(explore)
	explore.Filex.mode = mode
