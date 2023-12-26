extends CanvasLayer

onready var World3D: Spatial = $World

var tile

var popup_pc_new: PackedScene = preload("res://Scene/Popups/Popup_PC.tscn")
var file_explore_new: PackedScene = preload("res://Scene/Popups/File_explore.tscn")

func _ready() -> void:
	Index.edit_node = self

func warning_pc(text: String,object: Node,OK: String,CANCEL: String) -> void:
	var pop = popup_pc_new.instance()
	
	pop.text = text
	pop.connect("CANCEL",object,CANCEL)
	pop.connect("OK",object,OK)
	
	add_child(pop)


func file_explore(files : Array,object: Node,OK: String,CANCEL: String) -> void:
	var explore = file_explore_new.instance()
	
	explore.files = files
	explore.connect("CANCEL",object,CANCEL)
	explore.connect("OK",object,OK)
	
	add_child(explore)
