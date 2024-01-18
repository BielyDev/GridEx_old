extends Node2D

export(bool) var from: bool = true

onready var Par: PanelContainer = $"../../../.."

var mouse: bool = false


func _input(_event: InputEvent) -> void:
	
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and mouse:
		if from:
			global_position = get_global_mouse_position()
			
			position.x = clamp(position.x,0,244)
			position.y = clamp(position.y,0,244)
			
			Par.gradient2d.fill_from.x = position.x * 0.004096
			Par.gradient2d.fill_from.y = position.y * 0.004096
		else:
			global_position = get_global_mouse_position()
			
			position.x = clamp(position.x,0,244)
			position.y = clamp(position.y,0,244)
			
			Par.gradient2d.fill_to.x = position.x * 0.004096
			Par.gradient2d.fill_to.y = position.y * 0.004096


func _on_Point_button_down() -> void:
	mouse = true
func _on_Point_button_up() -> void:
	mouse = false

