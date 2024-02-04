extends Control

onready var Layer: Button = $Layer
onready var Lock: TextureButton = $Lock
onready var Visible: TextureButton = $Visible
onready var PopupOptions: CanvasLayer = $Layer/Popup
onready var Vbox: VBoxContainer = $Layer/Popup/Panel/Vbox
onready var Name: LineEdit = $Layer/Name

var Layer3d: Spatial
var Eyes: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Eyes.tres")
var EyesClosed: AtlasTexture = preload("res://Assets/2D/Atlas/UI/EyesClosed.tres")
var Layout_void: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Layout_void.tres")
var Layout_item: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Layout_item.tres")
var Par

func _ready() -> void:
	Layer.text = Layer3d.name
	yield(get_tree().create_timer(0.05),"timeout")
	_on_Layer_pressed()
	
	verific_item()
	
	Layer3d.connect("child_entered_tree",self,"_child_entered")
	Layer3d.connect("child_exiting_tree",self,"_child_exited")



func delete() -> void:
	if Index.block.get_child_count() > 1:
		
		Index.layer_select -= 1
		if Index.layer_select <= -1:
			Index.layer_select = 0
		
		Layer3d.queue_free()
		queue_free()
		
	else:
		IndexLayer.popup_one("Minimal layer limit!")


func _on_Layer_pressed() -> void:
	Index.layer_select = Layer3d.get_index()
	Par.selected(self)


func _on_Lock_pressed() -> void:
	pass


func _on_Tex_pressed() -> void:
	Layer3d.visible = !Layer3d.visible
	
	verific_visible()


func verific_visible() -> void:
	if Layer3d.visible:
		Visible.texture_normal = Eyes
	else:
		Visible.texture_normal = EyesClosed



func _child_exited(_node:Spatial) -> void:
	if Layer3d.get_child_count() == 1:
		Layer.icon = Layout_void
		Layer.hint_tooltip = "Void"
func _child_entered(_node:Spatial) -> void:
	verific_item()

func verific_item():
	if Layer3d.get_child_count() >= 1:
		Layer.icon = Layout_item
		Layer.hint_tooltip = str(Layer3d.get_child_count()," Tiles")

