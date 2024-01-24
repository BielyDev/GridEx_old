extends Control

onready var Layer: Button = $Layer
onready var Lock: TextureButton = $Lock
onready var Visible: TextureButton = $Visible
onready var Fav: TextureButton = $Layer/Favorite
onready var PopupOptions: Popup = $Layer/Popup
onready var Favorite: Button = $Layer/Popup/Vbox/Favorite
onready var Vbox: VBoxContainer = $Layer/Popup/Vbox
onready var Name: LineEdit = $Layer/Name

var Layer3d: Spatial
var Eyes: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Eyes.tres")
var EyesClosed: AtlasTexture = preload("res://Assets/2D/Atlas/UI/EyesClosed.tres")

var Par

func _ready() -> void:
	Layer.text = Layer3d.name
	yield(get_tree().create_timer(0.05),"timeout")
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


func _on_Layer_gui_input(_event: InputEvent) -> void:
	if _event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			PopupOptions.popup(
				Rect2(
					get_global_mouse_position().x-Vbox.rect_size.x,
					get_global_mouse_position().y-(Vbox.rect_size.y/2),
					Vbox.rect_size.x,Vbox.rect_size.y
					)
				)


func _on_Favorite_pressed() -> void:
	Fav.visible = !Fav.visible
	
	if Fav.visible:
		Favorite.text = "Remove from favorites"
	else:
		Favorite.text = "Add favorites"
	
	PopupOptions.hide()


func _on_Duplicate_pressed() -> void:
	var new_layer = Layer3d.duplicate()
	new_layer.name = str(Layer3d.name," ","duplicate")
	Index.block.add_child(new_layer)
	
	PopupOptions.hide()


func _on_Delete_pressed() -> void:
	delete()

func delete() -> void:
	if Index.block.get_child_count() > 1:
		Layer3d.queue_free()
		queue_free()
	else:
		IndexLayer.popup_one("Minimal layer limit!")


var foco: bool = false
func _on_Rename_pressed() -> void:
	Name.show()
	Name.text = Layer3d.name
	
	PopupOptions.hide()
	Name.call_deferred("grab_focus")
	foco = true


func _on_Name_gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ENTER):
			if Name.text.length() >= 1:
				Layer3d.name = Name.text
				Layer.text = Name.text
			
			Name.hide()


func _on_Rename_focus_exited() -> void:
	if foco:
		Name.hide()
		foco = false
