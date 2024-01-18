extends Button

onready var Par: PanelContainer = $"../../../../.."

var mouse: bool = false
var id: int = 0

func _ready() -> void:
	connect("button_down",self,"_on_Point_button_down")
	connect("button_up",self,"_on_Point_button_up")
	connect("color_changed",self,"change_color")
	
	mouse_default_cursor_shape = Control.CURSOR_HSPLIT

func _input(_event: InputEvent) -> void:
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and mouse:
		rect_global_position.x = get_global_mouse_position().x
		
		rect_position.x = clamp(rect_position.x,0,244)
		
		Par.gradient.set_offset(id,rect_position.x * 0.0040)


func change_color(_color_value: Color) -> void:
	Par.gradient.set_color(id,_color_value)

func _on_Point_button_down() -> void:
	mouse = true
func _on_Point_button_up() -> void:
	mouse = false



func _on_Color_Control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			Par.gradient.remove_point(id)
			queue_free()
