extends GraphTiles

onready var tile_script: PanelContainer = $"../../.."

var nodes_selection: Array
var nodes_copy: Array


#Connection and disconnection =====================

func _on_GraphEdit_connection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	connection_request(from,from_slot,to,to_slot)

func _on_GraphEdit_disconnection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	disconnection_request(from,from_slot,to,to_slot)



#Selected and unseleted ===================================

func _on_GraphEdit_node_selected(node: Node) -> void:
	nodes_selection.append(node)

func _on_GraphEdit_node_unselected(node: Node) -> void:
	nodes_selection.erase(node)



func _on_GraphEdit_copy_nodes_request() -> void:
	nodes_copy = nodes_selection.duplicate()
func _on_GraphEdit_paste_nodes_request() -> void:
	for nodes in nodes_copy:
		duplicate_nodes(nodes)


func _on_GraphEdit_duplicate_nodes_request() -> void:
	for nodes in nodes_selection:
		duplicate_nodes(nodes)


func _on_GraphEdit_delete_nodes_request(nodes: Array) -> void:
	for i in nodes:
		i.queue_free()


#Popup click_right config ===========================
func _on_GraphEdit_popup_request(position: Vector2) -> void:
	tile_script.menu_option.popup(position)


func _on_GraphEdit_child_exiting_tree(node: Node) -> void:
	for list in get_connection_list():
		
		if get_node(list.from) == node:
			disconnect_node(list.from,list.from_port,list.to,list.to_port)
		if get_node(list.to) == node:
			disconnect_node(list.from,list.from_port,list.to,list.to_port)

