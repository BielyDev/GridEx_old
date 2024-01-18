extends Control


onready var File_node: MenuButton = $"%File"


func _on_Add_pressed() -> void:
	File_node.press(6)


func _on_Edit_pressed() -> void:
	pass # Replace with function body.


func _on_Remove_pressed() -> void:
	pass # Replace with function body.


func _on_Import_pressed() -> void:
	File_node.press(7)
