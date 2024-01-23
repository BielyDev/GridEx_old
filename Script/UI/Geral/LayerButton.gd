extends Control

onready var Layer: Button = $Layer
onready var Lock: TextureButton = $Lock
onready var Visible: TextureButton = $Visible

var Layer3d: Spatial
var Eyes: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Eyes.tres")
var EyesClosed: AtlasTexture = preload("res://Assets/2D/Atlas/UI/EyesClosed.tres")

var Par

func _ready() -> void:
	Layer.text = Layer3d.name
	_on_Button_pressed()


func _on_Button_pressed() -> void:
	Index.layer_select = Layer3d.get_index()
	Par.selected(self)


func _on_Lock_pressed() -> void:
	pass


func _on_Tex_pressed() -> void:
	Layer3d.visible = !Layer3d.visible
	
	if Layer3d.visible:
		Visible.texture_normal = Eyes
	else:
		Visible.texture_normal = EyesClosed
