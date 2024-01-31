extends Control

enum TYPE {BOOL,NUM,OPTION,VECTOR,COLOR,TEXTURE}

var propriety = preload("res://Scene/Import/Propriety.tscn")
var new_propriety = propriety.instance()

onready var Propriety: VBoxContainer = $Propriety/Vbox
onready var Models: Spatial = $"%Models"
onready var Vector: VBoxContainer = $Propriety/Vbox/Vector
onready var Vbox: VBoxContainer = $Propriety/Vbox


export(String) var Propriety_name: String
export(TYPE) var Type: int
var node: Node
var call_func: String


func _ready() -> void:
	
	new_propriety.mat = node
	new_propriety.types.append({name = Propriety_name,type = Type,others = []})
	
	
	Vbox.add_child(new_propriety)
	new_propriety.Hide_show.visivel = true
	#new_propriety.Hide_show.show_animated()
	
	Vbox.move_child(new_propriety,0)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if mouse == false:
			queue_free()


func _on_Ok_pressed() -> void:
	node.call(call_func)
	queue_free()


var mouse: bool = false

func _on_Mouse_mouse_entered() -> void:
	mouse = true
func _on_Mouse_mouse_exited() -> void:
	mouse = false
