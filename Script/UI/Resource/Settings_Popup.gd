extends CanvasLayer

onready var Vbox: VBoxContainer = $Settings_Popup/Panel/Vbox

export(bool) var delete: bool = true
onready var Settings_popup: Popup = $Settings_Popup

func _ready() -> void:
	if delete:
		popup_mouse()

func popup_mouse() -> void:
		Settings_popup.popup(
			Rect2(
				Settings_popup.get_global_mouse_position().x-Vbox.rect_size.x-20,
				Settings_popup.get_global_mouse_position().y-(Vbox.rect_size.y/2),
				Vbox.rect_size.x,Vbox.rect_size.y
				)
			)

func create_button(object_conect: Node,_name: String,call_pressed: String,icon: Texture = null,size: Vector2 = Vector2(228,20)) -> Button:
	var new_button = Button.new()
	
	new_button.expand_icon = true
	
	new_button.text = _name
	new_button.icon = icon
	new_button.rect_size = size
	
	new_button.align = Button.ALIGN_LEFT
	new_button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	new_button.connect("pressed",object_conect,call_pressed)
	
	Vbox.add_child(new_button)
	
	return new_button

func new_separator() -> HSeparator:
	var new_hs = HSeparator.new()
	
	Vbox.add_child(new_hs)
	
	return new_hs


func _on_Settings_Popup_popup_hide() -> void:
	if delete: queue_free()
