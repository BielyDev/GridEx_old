extends Control

onready var Layers: VBoxContainer = $Config/Layers
onready var Selected: Control = $Config/Selected

var new_layerbutton: PackedScene = preload("res://Scene/UI/Resources/LayerButton.tscn")

func _ready() -> void:
	yield(get_tree().create_timer(0.2),"timeout")
	Index.block.connect("child_entered_tree",self,"add_layer")
	
	#selected(Layers.get_child(0))

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
	var new_layer = CSGCombiner.new()
	var num: int = Index.block.get_child_count()
	var nome = str("Layer ", num)
	
	for layers in Index.block.get_children():
		if layers.name == nome:
			num = layers.name.to_int()+num
			nome = str("Layer ", num)
	
	
	new_layer.name = nome
	
	Index.block.call_deferred("add_child",new_layer)


func _on_Delete_pressed() -> void:
	Layers.get_child(Index.layer_select).delete()

