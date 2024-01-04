extends Control

signal OK()

onready var Models: Spatial = $"%Models"
onready var Tree_models: Tree = $"%Tree"
onready var Propriety: PanelContainer = $Screen/Hbox/TreePanel/Vbox/ProprietyPanel
onready var Save: Node = $Save

var tile_icon: AtlasTexture = load("res://Assets/2D/Atlas/UI/Tile.tres")
var group_tile_icon: AtlasTexture = load("res://Assets/2D/Atlas/UI/Group_tile.tres")

var group: Array = []
var item: Array = []
var root: TreeItem

func _ready() -> void:
	UI.ready_animated_complex($Screen,$Background)
	
	root = Tree_models.create_item()
	root.set_text(0,"All")
	
	create_groups()


func _input(_event: InputEvent) -> void:
	var item_select = get_item_selection() 
	if item_select != null:
		Propriety.show()
		Propriety.tile_selected(item_select.node)
	else:
		Propriety.hide()


func confirm_add_group() -> void:
	IndexLayer.popup_two(
		"Do you really want to create a new group?",
		self,
		"create_groups",
		"cancel_groups"
	)
	


func create_groups() -> void:
	var new_group = Tree_models.create_item(root)
	var tree_name = str("Group_",Models.get_child_count())
	new_group.set_text(0,tree_name)
	new_group.set_icon(0,group_tile_icon)
	new_group.is_editable(0)
	
	var Group_node: Spatial = Spatial.new()
	
	Models.add_child(Group_node)
	Group_node.set_owner(Models)
	Group_node.name = tree_name
	
	group.push_back({tree = new_group,node = Group_node})


func cancel_groups() -> void:
	pass


func delete_groups() -> void:
	for node in group:
		if node.tree == Tree_models.get_selected():
			Tree_models.get_selected().get_parent().remove_child(Tree_models.get_selected())
			
			for child in node.node.get_children():
				delete_itens(node,child)
			
			node.node.queue_free()
			group.erase(node)
			
			return


func delete_itens(group_selected,item_selected):
	for i in group_selected.node.get_children():
		if i == item_selected:
			group_selected.erase(i)


func add_item(node_ins: Spatial,tile_name: String) -> void:
	for node in group:
		if node.tree == Tree_models.get_selected():
			node_ins.name = str(tile_name,"_",node.node.get_child_count())
			
			node.node.add_child(node_ins)
			node_ins.set_owner(node.node)
			
			var treenode = Tree_models.create_item(node.tree)
			treenode.set_text(0,node_ins.name)
			treenode.set_icon(0,tile_icon)
			
			item.append({tree = treenode,node = node_ins})
			return


func is_tree_selection() -> bool:
	for node in group:
		if node.tree == Tree_models.get_selected():
			return true
	
	return false


func get_item_selection():
	for node in item:
		if node.tree ==  Tree_models.get_selected():
			return node
	
	return null


func save_groups(path,file) -> void:
	Save.save_groups(path,file)

func cancel_file() -> void:
	pass


func _on_Add_pressed() -> void:
	confirm_add_group()

func _on_Delete_pressed() -> void:
	delete_groups()

func _on_Import_pressed() -> void:
	IndexLayer.file_explore(["*.tscn"],self,"save_groups","cancel_file",FileDialog.MODE_OPEN_DIR)

func _on_Close_pressed() -> void:
	yield(UI.queue_animated(self),"completed")
	emit_signal("OK")

