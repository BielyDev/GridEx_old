extends Button

class_name AnimationButtonClass

export(Color) var Color_pressed_back: Color = Color.rosybrown
export(Color) var Color_pressed_front: Color = Color.white
export(Vector2) var Scale_pressed: Vector2 = Vector2(1.2,1.2)

func _ready() -> void:
	rect_pivot_offset = rect_size/2

func button_animated() -> void:
	IndexLayer.edit.enabled = false
	Index.animated_tween_ui(self,"rect_scale", Scale_pressed,Vector2(1,1))
	Index.animated_tween_ui(self,"modulate", Color_pressed_back,Color_pressed_front)


