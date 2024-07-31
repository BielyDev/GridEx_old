extends AnimationButtonClass

signal is_pressed(idx,value)

var value
var my_panel

func _pressed() -> void:
	emit_signal("is_pressed",get_index(),value)
	
	my_panel.hide()
	my_panel.is_visible = false
