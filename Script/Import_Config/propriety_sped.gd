extends Control

enum TYPE {BOOL,NUM,OPTION,VECTOR,COLOR,TEXTURE}

var propriety = preload("res://Scene/Import/Propriety.tscn")
var new_propriety = propriety.instance()

onready var Propriety: VBoxContainer = $Propriety/Vbox
onready var Models: Spatial = get_node_or_null("%Models")
onready var Vector: VBoxContainer = $Propriety/Vbox/Vector
onready var Vbox: VBoxContainer = $Propriety/Vbox
onready var Tittle: Label = $Propriety/Vbox/Tittle

export(String) var Propriety_name: String
export(TYPE) var Type: int

var node: Node
var call_func: String
var others: Array = ["",null] #others["name","[value]"]


func _ready() -> void:
	Tittle.text = str(Propriety_name,"_value")
	new_propriety.mat = node
	new_propriety.types.append({name = Propriety_name,type = Type,others[0] : others[1]})
	
	Vbox.add_child(new_propriety)
	new_propriety.Hide_show.visivel = true
	Vbox.move_child(new_propriety,1)
	
	yield(get_tree().create_timer(0.3),"timeout")
	new_propriety.Hide_show.show_animated()


func _on_Ok_pressed() -> void:
	node.call(call_func)
	queue_free()


var mouse: bool = false


