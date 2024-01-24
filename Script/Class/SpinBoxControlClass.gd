extends SpinBox

class_name SpinBoxControl

export(Vector2) var Scale_pressed: Vector2 = Vector2(1.2,1.2)

var value_save: float
var color_up: Array = [Color.red,Color.aqua]

func _ready() -> void:
	rect_pivot_offset = rect_size/2
	
	connect("value_changed",self,"change")


func change(value) -> void:
	var up: int = 1
	
	up = int(value > value_save)
	value_save = value
	
	button_animated(up)
	rounded = Input.is_key_pressed(KEY_CONTROL)

func button_animated(up: int) -> void:
	var TwUI = TweenUI.new()
	TwUI.delete = true
	add_child(TwUI)
	
	TwUI.animated_tween_ui(self,"rect_scale", Scale_pressed,Vector2(1,1))
	TwUI.animated_tween_ui(self,"modulate", color_up[up],Color.white)

