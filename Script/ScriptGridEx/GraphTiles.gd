extends GraphEdit

class_name GraphTiles

var output: String


func disconnection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	
	get_node(from).emit_signal("disconnect_to",get_node(to))
	get_node(to).emit_signal("disconnect_from",get_node(from))
	
	get_node(to).from_delete(get_node(from))
	
	get_node(from).disconnect("change_value",get_node(to),"emit_from_value")
	
	if get_node(to).is_output:
		set_is_output(from,to,false,true)
	
	disconnect_node(from,from_slot,to,to_slot)
	
	get_node(to).from_functions.erase(get_node(from).from_functions)



func connection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
	connect_node(from,from_slot,to,to_slot)
	get_node(from).emit_signal("connected")
	
	set_is_output(from,to,get_node(to).is_output)
	
	get_node(from).connect("change_value",get_node(to),"emit_from_value")
	
	get_node(to).from_value.append({node = get_node(from), idx = get_node(from).get_slot_type_right(from_slot),to_slot = to_slot})
	 
	get_node(from).emit_signal("change_value",get_node(from).value)
	
	get_node(from).emit_signal("connected_to",get_node(to))
	get_node(to).emit_signal("connected_from",get_node(from))


func set_is_output(from: String, to: String, value: bool, first: bool = true) -> void:
	if first:
		get_node(from).is_output = value
	
	for connections in get_connection_list():
		if connections.to == from:
			get_node(connections.from).is_output = value
			set_is_output(connections.from,connections.to,value,false)


func duplicate_nodes(node) -> void:
	if is_instance_valid(node):
		var new_slot = node.duplicate()
		new_slot.value = null
		new_slot.from_value = []
		
		add_child(new_slot)
		
		new_slot.offset.x += 20
		new_slot.offset.y += 20


