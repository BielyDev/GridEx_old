extends Button

class_name AnimationButtonClass

export(Color) var Color_pressed_back: Color = Color.white
export(Color) var Color_pressed_front: Color = Color.white
export(Vector2) var Scale_pressed_up: Vector2 = Vector2(1.1,1.1)
export(Vector2) var Scale_pressed_down: Vector2 = Vector2(0.8,0.8)
export(float) var speed: float = 0.4
export(
	int,
	"TRANS_BACK",
	"TRANS_BOUNCE",
	"TRANS_CIRC",
	"TRANS_CUBIC",
	"TRANS_ELASTIC",
	"TRANS_EXPO"
) var transition: int = 0

var Tw: Tween = Tween.new()

func _ready() -> void:
	add_child(Tw)
	center_pivot()
	
	connect("button_down",self,"button_animated_down")
	connect("button_up",self,"button_animated_up")


func center_pivot() -> void:
	rect_pivot_offset = rect_size/2


func button_animated_down() -> void:
	IndexLayer.edit.enabled = false
	
	Tw.interpolate_property(self,"rect_scale", rect_scale,Scale_pressed_down,speed,transition)
	Tw.start()
	
	Tw.interpolate_property(self,"modulate",Color_pressed_front,Color_pressed_back,speed,transition)
	Tw.start()

func button_animated_up() -> void:
	IndexLayer.edit.enabled = false
	
	Tw.interpolate_property(self,"rect_scale", Scale_pressed_up,Vector2(1,1),speed,transition)
	Tw.start()
	
	Tw.interpolate_property(self,"modulate", Color_pressed_back,Color_pressed_front,speed,transition)
	Tw.start()
