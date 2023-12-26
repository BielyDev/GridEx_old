extends Control

signal OK()
signal CANCEL()

onready var Text: Label = $Panel/Vbox/Text

var text: String

func _ready() -> void:
	Text.text = text


func _on_Ready_pressed() -> void:
	emit_signal("OK")
	queue_free()

func _on_Cancel_pressed() -> void:
	emit_signal("CANCEL")
	queue_free()
