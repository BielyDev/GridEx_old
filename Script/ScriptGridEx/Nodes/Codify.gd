extends Node

onready var codify: GraphNode = $".."
onready var text: TextEdit = $"../Text"



func _on_Text_text_changed() -> void:
	codify.value = text.text
