extends VSeparator

export(NodePath) var Panel_Path: NodePath
export(bool) var Xpo: bool = true

onready var Panel_node := get_node(Panel_Path)

var mouse: bool = false
var mouse_tab: int = -1

var save_pos: Vector2

func _ready() -> void:
	connect("mouse_entered",self,"mouse_enter")
	connect("mouse_exited",self,"mouse_exit")

func _input(_event: InputEvent) -> void:
	if mouse:
		if Input.is_mouse_button_pressed(BUTTON_LEFT):
			if _event is InputEventMouseMotion:
				
				if Xpo:
					if save_pos == Vector2():
						save_pos = Panel_node.rect_global_position
					
					Panel_node.rect_min_size.x = (Panel_node.rect_min_size.x + save_pos.x) + _event.relative.x
				else:
					if save_pos == Vector2():
						save_pos.x = 0#Panel_node.rect_global_position.distance_to(Index.edit_node.get_child(0).rect_size)
					
					Panel_node.rect_min_size.x = (Panel_node.rect_min_size.x + save_pos.x) - _event.relative.x
	
	if Input.is_action_just_released("click_left"):
		save_pos = Vector2()

func mouse_enter() -> void:
	mouse = true
func mouse_exit() -> void:
	mouse = false


func _on_Tab_tab_selected(tab: int) -> void:
	mouse_tab = tab
