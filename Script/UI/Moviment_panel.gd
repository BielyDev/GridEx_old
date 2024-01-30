extends Control

export(NodePath) var Panel_Path: NodePath
export(bool) var Y: bool = false
export(bool) var Negative: bool = false

onready var Panel_node := get_node(Panel_Path)

var mouse: bool = false
var mouse_tab: int = -1

var save_pos: bool

func _ready() -> void:
	connect("mouse_entered",self,"mouse_enter")
	connect("mouse_exited",self,"mouse_exit")


func _input(_event: InputEvent) -> void:
	if mouse:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			if _event is InputEventMouseMotion:
				movement(_event.relative)
	
	if Input.is_action_just_released("click_left"):
		save_pos = true



func movement(mouse: Vector2) -> void:
	if Y:
		if save_pos == true:
			Panel_node.rect_min_size.y = Panel_node.rect_size.y
			save_pos = false
		
		if Negative: Panel_node.rect_min_size.y = Panel_node.rect_min_size.y + mouse.y
		else:Panel_node.rect_min_size.y = Panel_node.rect_min_size.y - mouse.y
		
	else:
		if save_pos == true:
			Panel_node.rect_min_size.x = Panel_node.rect_size.x
			save_pos = false
		
		if Negative:Panel_node.rect_min_size.x = Panel_node.rect_min_size.x + mouse.x #Mouse are event.relative 
		
		
		
		else: Panel_node.rect_min_size.x = Panel_node.rect_min_size.x - mouse.x


func mouse_enter() -> void:
	mouse = true
func mouse_exit() -> void:
	mouse = false


func _on_Tab_tab_selected(tab: int) -> void:
	mouse_tab = tab
