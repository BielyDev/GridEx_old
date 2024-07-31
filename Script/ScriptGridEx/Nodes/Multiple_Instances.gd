extends GNode

func _ready() -> void:
	value = []

func _on_New_instance_pressed() -> void:
	var ct = Control.new()
	
	add_child(ct)
	set_slot(get_child_count()-3,true,0,Color(1, 1, 1),false,0,Color.black)


func _on_Remove_pressed() -> void:
	if get_child_count() > 3:
		for i in graph_edit.get_connection_list():
			if i.to == name:
				graph_edit.disconnect_node(i.from,i.from_port,i.to,i.to_port)
		
		get_child(get_child_count()-1).queue_free()
	
	rect_size = Vector2()



func _on_MultipleInstances_from_value(new_value) -> void:
	add_value(new_value)
	
	#if !new_value.get_parent().is_connected("change_value",self,"emit_value_from"):
	#	new_value.get_parent().connect("change_value",self,"emit_value_from")


func add_value(new_value) -> void:
	for _value in value:
		if _value == new_value:
			return
	
	value.append(new_value)

func emit_value_from(_value) -> void:
	
	emit_signal("change_value",value)
	#self.value = _value

func _on_MultipleInstances_disconnect(_value) -> void:
	for i in value:
		if i == _value:
			value.erase(i)
	
	delete_instances(_value)

func delete_instances(_value):
	if _value is Node:
		_value.get_parent().clear()



func _on_MultipleInstances_change_is_output(new_value) -> void:
	if new_value == false:
		for i in value:
			delete_instances(i)


func _on_MultipleInstances_disconnect_from(_value) -> void:
	for i in value:
		if i == _value:
			value.erase(_value)
