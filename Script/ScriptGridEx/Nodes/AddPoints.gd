extends GNode

signal completed_start()

onready var points: Node = $Points
onready var vector_node: VBoxContainer = $Vector/Position/Vector
onready var offset_node: VBoxContainer = $Offset/Position/Offset_control
onready var rotation_node: VBoxContainer = $Rotation/Vbox/Rotation/Rotation
onready var offset_3d: Spatial = $Offset3d
onready var pick_instance_rotation_node: CheckBox = $Rotation/Vbox/pick_instance_rotation
onready var density_node: SpinBox = $Density/Density/DensityValue


var density: int = 0 setget _density
var seed_value: int = 0
var vector: Vector3 = Vector3() setget _vector
var vector_array: Array = [] setget _vector_array
var rotation_value: Vector3 = Vector3() setget _rotation
var offset_value: Vector3 = Vector3() setget _offset
var pick_instance_rotation: bool = false
var new_vector: bool = false

func _ready() -> void:
	emit_from_value_null = true
	
	vector_node.node = self
	vector_node.propriety = "vector"
	offset_node.node = self
	offset_node.propriety = "offset_value"
	rotation_node.node = self
	rotation_node.propriety = "rotation_value"
	
	self.vector = Vector3(1,1,1)

func _process(delta: float) -> void:
	hint_tooltip = str(points.get_child_count()," instances")


#--------- new functions
func _start() -> void: # Function
	generator(density)
	
	_update_vector()
	_update_model()
	
	call_deferred("emit_signal","completed_start")


func generator(_amount) -> void:
	for i in _amount:
		add_mesh()

#Instances change=========================================
func add_mesh() -> void:
	var mesh = MeshInstance.new()
	points.add_child(mesh)

func clear() -> void:
	for child in points.get_children():
		child.queue_free()
#=========================================================

var pass_size: int

func _update_vector() -> void:
	seed(seed_value)
	var apply_vector = vector_array

	pass_size = 0
	apply_vector.shuffle()
	
	for child in points.get_children():
		set_rotation_point(child)
		set_position_point(child,apply_vector)

func _update_model() -> void:
	var from
	
	for _from in from_value:
		if _from.idx == 1:
			from = _from
	#get_from_value(TYPE.DICTIONARY)
	
	if from != null and from.node.value != null:
		for child in points.get_children():
			var model: Tile = gridex.search_tile(from.node.value.id_group,from.node.value.id_tile)
			
			child.mesh = model.mesh
			
			child.material_overlay = model.material_overlay
			for surfaces in model.get_surface_material_count():
				child.set_surface_material(surfaces, model.get_surface_material(surfaces))
	
	else:
		var ball = SphereMesh.new()
		var mat = SpatialMaterial.new()
		
		for child in points.get_children():
			
			mat.flags_unshaded = true
			
			ball.material = mat
			ball.surface_set_material(0,null)
			
			ball.radius = 0.2
			ball.height = 0.4
			ball.radial_segments = 8
			ball.rings = 4
			
			child.mesh = ball

func _update_from_value(_node) -> void:
	for from in from_value:
		if from.node == _node:
			match from.idx:
				1:
					_update_model()
				3:
					match from.to_slot:
							
						3:
							vector_node.hide()
							new_vector = true
							
							if from.node.value is Vector3:
								vector = from.node.value
								vector_array = []
							if from.node.value is Array:
								vector_array = from.node.value
								vector = Vector3()
							
							_update_vector()
						4:
							rotation_node.hide()
							rotation_value = from.node.value
							_update_vector()
						5:
							offset_node.hide()
							offset_3d.position = from.node.value
							_update_vector()
				5:
					match from.to_slot:
						1:
							density_node.hide()
							self.amount = from.node.value

#Transform
func set_position_point(child: Spatial,apply_vector) -> void:
	if !new_vector:
		child.position = get_randpos()
	
	else:
		if vector_array == []:
			child.position = vector
		
		else:
			var index = child.get_index()
			
			if (index+1) == (apply_vector.size() * (pass_size+1)):
				pass_size += 1
			
			child.position = offset_3d.to_local(apply_vector[index-(pass_size*apply_vector.size())])

func set_rotation_point(child: Spatial) -> void:
	if pick_instance_rotation:
		child.rotation_degrees = rotation_value
		offset_3d.rotation_degrees = Vector3()
	else:
		offset_3d.rotation_degrees = rotation_value
		child.position = offset_3d.to_local(child.position)
		child.rotation_degrees = Vector3()

func get_randpos() -> Vector3:
	var vec_rand = Vector3(rand_range(-vector.x,vector.x),rand_range(-vector.y,vector.y),rand_range(-vector.z,vector.z))
	
	return offset_3d.to_local(vec_rand)

#---------- setget
func _density(_value:int) -> void:
	density = _value
	
	clear()
	
	if is_output:
		_start()
		
		yield(self,"completed_start")
		self.value = points
	
	value = points
	
	#Alterar depois
	yield(get_tree(),"idle_frame")
	_update_vector()

func _vector(vec: Vector3) -> void:
	vector = vec
	_update_vector()
	
	self.value = points

func _vector_array(ar: Array) -> void:
	vector_array = ar
	_update_vector()
	
	self.value = points

func _rotation(rot: Vector3) -> void:
	rotation_value = rot
	_update_vector()
	
	self.value = points

func _offset(vec: Vector3) -> void:
	offset_value = vec
	offset_3d.position = vec
	_update_vector()
	
	self.value = points


#---------- connections
func _on_SeedValue_value_changed(_value: float) -> void:
	seed_value = int(_value)
	
	self.value = points


func _on_DensityValue_value_changed(_value: float) -> void:
	self.density = _value


func _on_AddPoints_from_value(new_from) -> void:
	for from in new_from:
		_update_from_value(from.node)
	
	if is_output:
		self.value = points

func _on_AddPoints_connected() -> void:
	clear()
	yield(self,"change_is_output")
	
	if is_output:
		_start()
	
	self.value = points

func _on_AddPoints_change_is_output(new_value) -> void:
	if !is_output:
		clear()
	#else:
	#	_start()

func _on_AddPoints_disconnect_from(_node) -> void:
	for from in from_value:
		if from.node == _node:
			match from.idx:
				1:
					yield(get_tree(),"idle_frame")
					_update_model()
				3:
					match from.to_slot:
						3:
							if from.node.value is Array:
								vector_array = []
							
							vector_node.show()
							new_vector = false
							_update_vector()
						4:
							rotation_node.show()
							rotation_value = rotation_node.vector
							_update_vector()
						5:
							offset_node.show()
							offset_3d.position = offset_value
							_update_vector()
				5:
					match from.to_slot:
						1:
							density_node.show()
							self.density = density_node.value

func _on_AddPoints_connected_from(_node) -> void:
	_update_from_value(_node)


func _on_pick_instance_rotation_pressed() -> void:
	pick_instance_rotation = pick_instance_rotation_node.pressed
	_update_vector()
