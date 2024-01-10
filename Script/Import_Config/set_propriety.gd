extends Control

var mat: SpatialMaterial
var mat_propriety: String
var propriety: String
var mouse: bool = false

func _ready() -> void:
	connect("mouse_entered",self,"mouse_enter")
	connect("mouse_exited",self,"mouse_exit")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and mouse:
			pressed()


func pressed() -> void:
	mat.set(mat_propriety,get(propriety))
func mouse_enter():
	mouse = true
func mouse_exit():
	mouse = false
