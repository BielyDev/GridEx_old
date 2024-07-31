extends PanelContainer

export(Array,Resource) var Nodes_class: Array

onready var script_node: Node = $Script
onready var graph_edit: GraphEdit = $Vbox/Hbox/GraphEdit
onready var menu_option: Button = $Vbox/Buttons/MenuOption

var script_path = "res://Script/ScriptGridEx/Script.gd"


func _ready() -> void:
	create_buttons_popup()



func create_buttons_popup() -> void:
	
	var id = 0
	
	for groups in Nodes_class:
		menu_option.add_item(groups.group_name,-1,true)
		for nodes in groups.node:
			var button = menu_option.add_item_child(groups.group_name,nodes.get_file().get_basename(),-1,nodes)
			button.connect("is_pressed",self,"add_node")



func add_node(idx: int,path: String) -> void:
	var node = load(path).instance()
	
	graph_edit.add_child(node)
	node.offset = graph_edit.get_local_mouse_position() * graph_edit.zoom


func _on_Run_pressed() -> void:
	script_node.set_script(null)
	
	var file = File.new()
	
	file.open(script_path,File.WRITE)
	
	file.store_string(str("extends Node\nfunc start():\n	",graph_edit.output))
	file.close()
	
	
	yield(get_tree().create_timer(0.5),"timeout")
	script_node.set_script(load(script_path))
	yield(get_tree().create_timer(0.5),"timeout")
	script_node.start()

