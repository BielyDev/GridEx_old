extends Control

signal OK()
signal CONFIRM()
onready var Mat: VBoxContainer = $"%Materials"
onready var Models: Spatial = $"%Models"
onready var Tree_models: Tree = $"%Tree"
onready var ProprietyPanel: PanelContainer = $Vbox/Screen/Hbox/TreePanel/Vbox/ProprietyPanel
onready var Make_materials: Node = $Make_Materials
onready var Screen: PanelContainer = $Vbox/Screen
onready var view3d: Spatial = $"Vbox/Screen/Hbox/Vbox/View/Viewport/World3D/3D_View"
onready var Selection: MeshInstance = $Vbox/Screen/Hbox/Vbox/View/Viewport/World3D/Settings/Selection

var tile_icon: AtlasTexture = load("res://Assets/2D/Atlas/UI/Tile.tres")
var group_tile_icon: AtlasTexture = load("res://Assets/2D/Atlas/UI/Group_tile.tres")
var item_save: MeshInstance
var limpar: bool = true

var group: Array = []
var item: Array = []
var root: TreeItem
var go: bool

func _ready() -> void:
	UI.ready_animated_complex(Screen,$Background)
	
	root = Tree_models.create_item()
	root.set_text(0,"All")
	
	create_groups()


func _input(_event: InputEvent) -> void:
	var item_select = get_item_selection()
	
	if item_select != null:
		ProprietyPanel.show()
		
		if item_save != item_select.node:
			Make_materials.clear()
			ProprietyPanel.translation_value(false)
		
		item_save = item_select.node
		
		ProprietyPanel.tile_selected(item_select.node)
		
		if Mat.get_child_count() == 0:
			Make_materials.make(item_select.node)
			ProprietyPanel.translation_value(true)
		
		Selection.global_transform.origin = item_select.node.global_transform.origin
		Selection.scale = item_select.node.scale/1.5
		
		limpar = true
	else:
		if limpar:
			Make_materials.clear()
			limpar = false
			ProprietyPanel.translation_value(false)
		ProprietyPanel.hide()


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


func delete_groups() -> void:
	for node in group:
		if node.tree == Tree_models.get_selected():
			
			if node.node.get_child_count() >= 1:
				IndexLayer.popup_two(
					"Deseja mesmo excluir o grupo?",
					self,
					"confirm",
					"cancel"
					)
				
				yield(self,"CONFIRM")
				
				if go == false:
					return
			
			Tree_models.get_selected().get_parent().remove_child(Tree_models.get_selected())
			
			for child in node.node.get_children():
				delete_itens_selected(node,child)
			
			node.node.queue_free()
			group.erase(node)
			
			return


func delete_itens() -> void:
	for node in item:
		if node.tree == Tree_models.get_selected():
			Tree_models.get_selected().get_parent().remove_child(Tree_models.get_selected())
		
		node.node.queue_free()
		item.erase(node)
		return


func delete_nodes() -> void:
	#if is_tree_selection():
	#	 delete_groups()
	var _item = get_item_selection()
	print(_item)
	if _item != null:
		for node in group:
			if node.tree == Tree_models.get_selected():
				delete_itens_selected(node,node.node)
				return


func delete_itens_selected(group_selected:Dictionary ,item_selected: MeshInstance):
	for i in group_selected.node.get_children():
		if i == item_selected:
			item_selected.queue_free()
			group_selected.erase(i)


func confirm_add_group() -> void:
	IndexLayer.popup_two(
		"Do you really want to create a new group?",
		self,
		"create_groups",
		"cancel"
	)


func is_tree_selection() -> bool:
	for node in group:
		if node.tree == Tree_models.get_selected():
			return true
	
	return false


func get_item_selection():
	for node in item:
		if node.tree == Tree_models.get_selected():
			return node
	
	return null


func save_groups(path,file) -> void:
	Export.export_new_tiles(Models ,path)
	yield(get_tree().create_timer(3),"timeout")
	yield(UI.queue_animated(self),"completed")
	emit_signal("OK")

func cancel() -> void:
	go = false
	emit_signal("CONFIRM")
func confirm() -> void:
	go = true
	emit_signal("CONFIRM")
func close_confirm() -> void:
	yield(UI.queue_animated(self),"completed")
	emit_signal("OK")

func _on_Add_pressed() -> void:
	confirm_add_group()

func _on_Delete_pressed() -> void:
	delete_nodes()

func _on_Save_pressed() -> void:
	IndexLayer.file_explore(["*.tile"],self,"save_groups","cancel",FileDialog.MODE_OPEN_DIR)

func _on_Close_pressed() -> void:
	IndexLayer.popup_two("Do you want to close without saving?",self,"close_confirm","cancel")


func _on_Vbox_mouse_entered() -> void:
	view3d.Pos.block_view = false
func _on_Vbox_mouse_exited() -> void:
	view3d.Pos.block_view = true



func _on_All_filters_toggled(button_pressed: bool) -> void:
	for groups in Models.get_children():
		for childs in groups.get_children():
			
			for mat in range(childs.mesh.get_surface_count()):
				if childs.mesh.surface_get_material(mat) != null:
					#yield(get_tree().create_timer(0.1),"timeout")
					var image: Texture = childs.mesh.surface_get_material(mat).albedo_texture
					
					if image != null:
						if button_pressed:
							image.flags = Texture.FLAGS_DEFAULT
						else:
							image.flags = Texture.FLAG_MIRRORED_REPEAT
