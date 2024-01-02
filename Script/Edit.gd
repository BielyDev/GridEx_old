extends CanvasLayer

var World3D

var tile

var popup_pc_new: PackedScene = preload("res://Scene/Popups/Popup_PC.tscn")
var file_explore_new: PackedScene = preload("res://Scene/Popups/File_explore.tscn")
#var world = load("res://Scene/World_Node.tscn")
onready var w = $World
onready var Edit: VBoxContainer = $Local/Vbox/Hbox/Edit

func _ready() -> void:
	#var w = world.instance()
	w.View = $Local/Vbox/Hbox/View/ViewPanel/View
	#add_child(w)
	w.Block.Option = $"%Option"
	w.Mirror = $"%Mirror"
	World3D = w
	
	Index.edit_node = self


func _input(event: InputEvent) -> void:
	Edit.visible = Index.mode == Index.MODE.ADD


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
