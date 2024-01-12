extends PanelContainer

var mouse: bool = false


func _ready() -> void:
	connect("mouse_entered",self,"mouse_enter")
	connect("mouse_exited",self,"mouse_exit")

func _input(_event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		rect_min_size.y = get_global_mouse_position().y


func mouse_enter() -> void:
	mouse = true
func mouse_exit() -> void:
	mouse = false
