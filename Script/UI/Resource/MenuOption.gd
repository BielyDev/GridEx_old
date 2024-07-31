extends AnimationButtonClass

onready var vbox: VBoxContainer = $Z/Panel/Vbox
onready var panel: PanelContainer = $Z/Panel
onready var z: CanvasLayer = $Z

var button: AnimationButtonClass = AnimationButtonClass.new()
var icon_child: AtlasTexture = load("res://Assets/2D/Atlas/UI/Hide_Arrow.tres")


func _ready() -> void:
	panel.button = self
	panel.connected()
	
	button.set_script(load("res://Script/UI/Resource/MenuOptionButton.gd"))
	button.align = Button.ALIGN_LEFT
	button.icon_align = Button.ALIGN_RIGHT
	button.mouse_filter = Button.MOUSE_FILTER_PASS
	button.input_pass_on_modal_close_click = false
	
	button.expand_icon = true


# Add item ====================================================================================
func add_item(item_name: String, idx: int = -1,child_item: bool = false,value = null) -> AnimationButtonClass:
	var new_button = _instance_item(vbox,item_name,idx,value)
	
	if child_item:
		new_button.icon = icon_child
	
	return new_button


func add_item_child(parent_name: String,item_name: String,idx: int = -1,value = null) -> AnimationButtonClass:
	for child in vbox.get_children():
		if child.text == parent_name:
			
			for my_child in z.get_children(): # Caso ja tenha um painel pra ele
				if my_child.name == parent_name:
					
					return _instance_item(my_child.get_child(0),item_name,idx,value)
			
			return _instance_item(create_panel(child).get_child(0),item_name,idx,value)
	
	return null

# ==============================================================================================

func create_panel(button_parent) -> PanelContainer:
	var new_panel = panel.duplicate()
	z.add_child(new_panel)
	
	for child in new_panel.get_child(0).get_children():
		child.queue_free()
	
	new_panel.name = button_parent.text
	new_panel.hide()
	
	new_panel.button = button_parent
	new_panel.connected()
	
	return new_panel


func _instance_item(new_vbox: VBoxContainer,item_name: String, idx: int = -1, value = null) -> AnimationButtonClass:
	var new_button = button.duplicate()
	
	new_button.value = value
	
	new_vbox.add_child(new_button)
	
	new_button.my_panel = new_vbox.get_parent()
	new_button.text = item_name
	
	if idx != -1:
		new_vbox.move_child(new_button,idx)
	
	return new_button

func popup(positon:Vector2) -> void:
	panel.show()
	panel.is_visible = true
	panel.rect_global_position = positon - (panel.rect_size/2)

