extends TabContainer

var mouse: bool = false
var mouse_tab: int = -1

var text = Label.new()

func _ready() -> void:
	
	connect("mouse_entered",self,"mouse_enter")
	connect("mouse_exited",self,"mouse_exit")

func _input(_event: InputEvent) -> void:
	if mouse:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			if mouse_tab != -1:
				
				if text.text == "":
					IndexLayer.add_child(text)
					text.align = Label.ALIGN_CENTER
					text.mouse_default_cursor_shape = Control.CURSOR_CROSS
					text.mouse_filter = Control.MOUSE_FILTER_STOP
				
				text.text = get_tab_title(mouse_tab)
				text.rect_global_position = get_global_mouse_position() - text.rect_size/2
	
	if Input.is_action_just_released("click_left"):
		if mouse_tab != -1:
			mouse_tab = -1
			text.queue_free()
			
			text = Label.new()


func mouse_enter() -> void:
	mouse = true
func mouse_exit() -> void:
	mouse = false


func _on_Tab_tab_selected(tab: int) -> void:
	mouse_tab = tab
