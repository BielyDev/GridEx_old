extends CanvasLayer

signal theme(tema)

var popup_two_new: PackedScene = preload("res://Scene/Popups/Popup_PC.tscn")
var popup_one_new: PackedScene = preload("res://Scene/Popups/Popup_OK.tscn")
var file_explore_new: PackedScene = preload("res://Scene/Popups/File_explore.tscn")
var importer_new: PackedScene = preload("res://Scene/Import/Import_Config.tscn")
var preference_new: PackedScene = preload("res://Scene/Preferences/Preferences.tscn")
var create_image_new: PackedScene = preload("res://Scene/ImageTile/ImageTile_Creator.tscn")
var light_panel_new: PackedScene = preload("res://Scene/Popups/Light_Control.tscn")

onready var Global: Control = $Global

var edit: Dictionary = {
	enabled = false,
	scene_path = "",
	other = null,
}


func theme_changed(tema: Theme) -> void:
	Global.theme = tema
	emit_signal("theme",tema)

func popup_two(text: String,object: Node,OK: String,CANCEL: String) -> void:
	var pop = popup_two_new.instance()
	
	pop.text = text
	pop.connect("CANCEL",object,CANCEL)
	pop.connect("OK",object,OK)
	
	Global.add_child(pop)

func popup_one(text: String,object: Node = null,OK: String = "") -> void:
	var pop = popup_one_new.instance()
	
	pop.text = text
	
	if object != null:
		pop.connect("OK",object,OK)
	
	Global.add_child(pop)

func importer_menu(object: Node,OK: String) -> void:
	var importer = importer_new.instance()
	
	Global.add_child(importer)
	importer.connect("OK",object,OK)

func create_image_menu(object: Node,OK: String) -> void:
	var create_image = create_image_new.instance()
	
	Global.add_child(create_image)
	create_image.connect("OK",object,OK)

func preferences_menu(object: Node,OK: String) -> void:
	var preference = preference_new.instance()
	
	Global.add_child(preference)
	preference.connect("OK",object,OK)

func light_panel(light: OmniLight) -> void:
	var li = light_panel_new.instance()
	li.LightConfig = light
	Global.add_child(li)


func call_export(scene_path,dir,no,call) -> void:
	var scene = load(scene_path).instance()
	scene.dir = dir
	Global.add_child(scene)
	scene.connect("finished",no,call)


func file_explore(files : Array,object: Node,OK: String,CANCEL: String, mode = FileDialog.MODE_SAVE_FILE) -> void:
	var explore = file_explore_new.instance()
	
	explore.files = files
	explore.connect("CANCEL",object,CANCEL)
	explore.connect("OK",object,OK)
	
	Global.add_child(explore)
	explore.Filex.mode = mode
