extends AnimationButtonClass

class_name Hide_and_show_animated

export(NodePath) var Node_effect: NodePath
export(Vector2) var Vec_max: Vector2 = Vector2(50,200)
export(Vector2) var Vec_min: Vector2 = Vector2(0,0)
export(bool) var visivel: bool = true
export(bool) var child_hide: bool = false

onready var no := get_node(Node_effect)

var show_arrow: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Show_Arrow.tres")
var hide_arrow: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Hide_Arrow.tres")

var TwUI: TweenUI = TweenUI.new()

func _ready() -> void:
	add_child(TwUI)
	connect("pressed",self,"touch")


func touch() -> void:
	visivel = !visivel
	
	if visivel:
		show_animated()
	else:
		hide_animated()

func hide_animated() -> void:
	icon = hide_arrow
	TwUI.animated_tween_ui(no,"rect_min_size",no.rect_min_size,Vec_min,0.4,Tween.TRANS_CUBIC)
	
	if child_hide:
		for child in no.get_children():
			child.hide()

func show_animated() -> void:
	icon = show_arrow
	TwUI.animated_tween_ui(no,"rect_min_size",no.rect_min_size,Vec_max)
	
	if child_hide:
		for child in no.get_children():
			child.show()
