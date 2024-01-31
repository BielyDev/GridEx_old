extends Control

onready var Layer: Button = $Layer
onready var Lock: TextureButton = $Lock
onready var Visible: TextureButton = $Visible
onready var Fav: TextureButton = $Layer/Favorite
onready var PopupOptions: Popup = $Layer/Popup
onready var Favorite: Button = $Layer/Popup/Panel/Vbox/Favorite
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
	_on_Button_pressed()
	
	Layer3d.connect("child_entered_tree",self,"_child_entered")
	Layer3d.connect("child_exiting_tree",self,"_child_exited")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if mouse_name == false:
			Name.hide()


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



func _child_exited(node:Spatial) -> void:
	if Layer3d.get_child_count() == 1:
		Layer.icon = Layout_void
		Layer.hint_tooltip = "Void"
func _child_entered(node:Spatial) -> void:
	if Layer3d.get_child_count() >= 1:
		Layer.icon = Layout_item
		Layer.hint_tooltip = str(Layer3d.get_child_count()," Tiles")

#Popup==========================================================

func _on_Layer_gui_input(_event: InputEvent) -> void:
	if _event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			_on_Button_pressed()
			PopupOptions.popup(
				Rect2(
					get_global_mouse_position().x-Vbox.rect_size.x-20,
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
		
		Index.layer_select -= 1
		if Index.layer_select <= -1:
			Index.layer_select = 0
		
		Layer3d.queue_free()
		queue_free()
		
	else:
		IndexLayer.popup_one("Minimal layer limit!")


func _on_Rename_pressed() -> void:
	Name.show()
	Name.text = Layer3d.name
	Name.select_all()
	
	PopupOptions.hide()
	Name.call_deferred("grab_focus")


func _on_Name_gui_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_ENTER):
			if Name.text.length() >= 1:
				Layer3d.name = Name.text
				Layer.text = Name.text
			
			Name.hide()



var mouse_name = false
func _on_Name_mouse_exited() -> void:
	mouse_name = false
func _on_Name_mouse_entered() -> void:
	mouse_name = true


func _on_Down_pressed() -> void:
	get_parent().move_child(self,get_index()+1)
	PopupOptions.hide()
func _on_Up_pressed() -> void:
	get_parent().move_child(self,get_index()-1)
	PopupOptions.hide()
