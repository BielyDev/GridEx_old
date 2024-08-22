extends Control

onready var PanelNode: PanelContainer = $Panel
onready var Background: PanelContainer = $Background

func _ready() -> void:
	UI.ready_animated_complex(PanelNode,Background)
	
	Index.block_view = true

func _unhandled_key_input(_event: InputEventKey) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		exit()

func _on_New_project_pressed() -> void:
	exit()

func _on_Back_pressed() -> void:
	exit()

func exit() -> void:
	UI.queue_animated_complex(self,PanelNode,Background)
	Index.block_view = false


func _on_what_pressed() -> void:
	OS.shell_open("https://bielydev.itch.io/gridex/devlog/785983/gridex-new-version-051")



