extends GNode

#---------
onready var vector_node: VBoxContainer = $Panel/Vector
onready var delete_duplicate_node: CheckBox = $Options/Vbox/Delete_duplicate
onready var include_group_node: CheckBox = $Options/Vbox/Include_group

#---------
var vector: Vector3 = Vector3(2,2,2) setget _new_vector
var delete_duplicate: bool = false
var include_group: bool = false
#---------
func _ready() -> void:
	vector_node.node = self
	vector_node.propriety = "vector"


#---------
func _new_vector(_value: Vector3) -> void:
	vector = _value
	
	yield(get_tree(),"idle_frame")
	
	filter_value()
	
	self.value = from_value
	pass_from_value(from_value)


func filter_value() -> void:
	for from in from_value:
		match from.idx:
			0:
				if from.node.value is Node:
					node(from.node)
				if from.node.value is Array:
					array(from.node.value)



func pass_from_value(_value) -> void:
	var save_points = []
	
	for from in from_value:
		if from.node.value is Node:
			filter_nodes(from.node.value.get_children())
		if from.node.value is Array:
			for nodes_array in from.node.value:
				if !include_group:
					for instances in nodes_array:
						filter_nodes(instances.node.value.get_children())
				else:
					for instances in nodes_array:
						for i in instances.node.value.get_children():
							save_points.append(i)
	
	filter_nodes(save_points)

func filter_nodes(points: Array) -> void:
	var pos = []
	var is_pos: bool
	
	for child in points:
		for_filter_nodes(child,pos,is_pos)
		
		pos.append(child.position)

func for_filter_nodes(child,pos,is_pos) -> void:
	if delete_duplicate == false:
		child.show()
		return
	
	for position in pos:
		if child.position == position:
			child.hide()
			is_pos = true
	
	if is_pos == false:
		child.show()


# Filters==================================
func node(_value: Node) -> void:
	if _value.points.get_child_count() > 0:
		seed(_value.seed_value)
		
		for child in _value.points.get_children():
			child.global_position = _value.get_randpos().snapped(vector)

func array(_value: Array) -> void:
	for i in _value:
		for from in i:
			node(from.node)


#---------
func _on_Snapped_from_value(new_value) -> void:
	_new_vector(vector)
	
	self.value = from_value
	pass_from_value(from_value)
func _on_Snapped_connected() -> void:
	yield(self,"change_is_output")
	
	if is_output:
		_new_vector(vector)
		
		self.value = from_value
		pass_from_value(from_value)

func _on_Delete_duplicate_pressed() -> void:
	delete_duplicate = delete_duplicate_node.pressed
	pass_from_value(from_value)
func _on_Include_group_pressed() -> void:
	include_group = include_group_node.pressed
	pass_from_value(from_value)


func _on_Snapped_instance_disconnect_from(node) -> void:
	delete_duplicate = false
	
	pass_from_value(node.value)
	_on_Delete_duplicate_pressed()
