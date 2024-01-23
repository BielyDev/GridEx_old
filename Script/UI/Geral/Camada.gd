extends Control

onready var Layers: VBoxContainer = $Scroll/Config/Layers
onready var Selected: Control = $Scroll/Config/Selected

var new_layerbutton: PackedScene = preload("res://Scene/UI/Resources/LayerButton.tscn")

func _ready() -> void:
	yield(get_tree().create_timer(0.2),"timeout")
	Index.block.connect("child_entered_tree",self,"add_layer")
	Index.block.connect("child_entered_tree",self,"add_layer")

func add_layer(node: Node) -> void:
	if node is Spatial:
		var layerbutton = new_layerbutton.instance()
		
		layerbutton.Layer3d = node
		layerbutton.Par = self
		Layers.add_child(layerbutton)

func remove_layer(node: Node) -> void:
	if node is Spatial:
		for childs in Layers.get_children():
			if childs.Layer3D == node:
				childs.queue_free()


func selected(node: Control) -> void:
	Selected.rect_global_position = node.rect_global_position
	Selected.rect_position -= Vector2(4,-4)



func _on_Add_pressed() -> void:
	var new_layer = Spatial.new()
	new_layer.name = str("Layer ", Index.block.get_child_count())
	
	Index.block.add_child(new_layer)
