extends Control

signal OK()
signal CANCEL()

onready var Text: Label = $Panel/Vbox/Text
onready var background: PanelContainer = $Background
onready var panel: PanelContainer = $Panel

var text: String

func _ready() -> void:
	UI.ready_animated_complex(panel,background)
	Text.text = text


func _on_Ready_pressed() -> void:
	emit_signal("OK")
	UI.queue_animated_complex(self,panel,background)


func _on_Cancel_pressed() -> void:
	emit_signal("CANCEL")
	UI.queue_animated_complex(self,panel,background)
