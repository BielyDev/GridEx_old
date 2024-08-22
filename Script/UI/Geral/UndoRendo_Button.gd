extends HBoxContainer



func _on_Undo_pressed() -> void:
	$Undo/t.pressed = true


func _on_Rendo_pressed() -> void:
	Input.action_press("")
