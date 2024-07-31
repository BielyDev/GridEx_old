extends GNode

onready var vector_node: VBoxContainer = $Panel/Vector
onready var delete_duplicate_node: CheckBox = $Options/Vbox/Delete_duplicate


var new_vector
var delete_duplicate: bool = false
var final_vector

var vector: Vector3 setget _vector

func _ready() -> void:
	vector_node.node = self
	vector_node.propriety = "vector"
	
	value = Vector3()


func update_vector(_node) -> void:
	if _node.value is Vector3:
		new_vector = _node.value.snapped(vector)
	
	if _node.value is Array:
		var save_vect = []
		new_vector = []
		
		for vec in _node.value:
			
			if delete_duplicate:
				var is_pass: bool
				
				for s in save_vect:
					
					if s.snapped(vector) == vec.snapped(vector):
						is_pass = true
				
				if is_pass == false:
					new_vector.append(vec.snapped(vector))
				
				save_vect.append(vec)
				
				is_pass = false
			#	print(new_vector.size(), " ",_node.value.size())
			#	print(save_vect)
			#	return
			
			
			#new_vector.append(vec.snapped(vector))


func _vector(_value: Vector3) -> void:
	vector = _value
	
	if from_value.size() > 0:
		update_vector(from_value[0].node)
	
	self.value = new_vector


func _on_Snapped_connected_from(_node) -> void:
	update_vector(_node)


func _on_Snapped_from_value(new_value) -> void:
	update_vector(new_value[0].node)
	
	self.value = new_vector


func _on_Delete_duplicate_pressed() -> void:
	delete_duplicate = delete_duplicate_node.pressed
	
	if from_value.size() > 0:
		update_vector(from_value[0].node)
