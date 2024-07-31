extends GraphNode
class_name GNode

enum TYPE {NODE,DICTIONARY,VECTOR,ARRAY,INT,TEXTURE}

signal from_value(new_value)
signal change_value(new_value)
signal change_is_output(new_value)
signal disconnect_from(node)
signal disconnect_to(node)

signal connected()
signal connected_from(node)
signal connected_to(node)



export(bool) var emit_from_value_null: bool = false

onready var graph_edit: GraphEdit = $".."

var value setget _setget_value
var from_functions = []
var from_value: Array setget _setget_from_value
var is_output: bool = false setget _setget_is_output

func _ready() -> void:
	connect("close_request",self,"close")
	connect("resize_request",self,"resize")
	
	debug()


func resize(size: Vector2) -> void:
	rect_size = size

func close() -> void:
	queue_free()

func get_from(idx,node = null):
	
	if node != null:
		for from in from_value:
			if from.node == node:
				return from
		return
	
	for from in from_value:
		if from.idx == idx:
			return from

func _setget_value(_value) -> void:
	value = _value
	emit_signal("change_value",value)

func emit_from_value( _value) -> void:
	var from_node
	
	for from in from_value:
		if typeof(from.node.value) == typeof(_value) and from.node.value == _value:
			from_node = get_from(0,from.node)
	
	if from_node != null:
		from_node.value = _value
	
	emit_signal("from_value",from_value)

func add_from_value(_idx,_node) -> void:
	if get_from(_idx,_node) == null:
		from_value.append({idx = _idx, node = _node})


func from_delete(node) -> void:
	
	for from in from_value:
		if from.node == node:
			from_value.erase(from)

func _setget_from_value(node) -> void:
	from_value = node
	
	if emit_from_value_null:
		emit_signal("from_value",from_value)


func _setget_is_output(_value) -> void:
	is_output = _value
	
	emit_signal("change_is_output",is_output)


# DEBUG ===============================


var button = CheckBox.new()
var label = Label.new()
var node = Node2D.new()

func debug() -> void:
	add_child(node)
	node.add_child(button)
	node.add_child(label)
	
	label.rect_position.y = 32
	node.position.x = rect_size.x
	button.connect("pressed",self,"button_pressed")
	
	label.hide()

func _process(delta: float) -> void:
	
	label.text = str("Value: ",value,"\n","From value: ",from_value,"\n","is_output: ",is_output,"\n","From_functions: ",from_functions,"\n")

func button_pressed() -> void:
	label.visible = button.pressed


