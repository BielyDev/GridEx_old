extends VBoxContainer


onready var Bool: SpinBox = $Save_time/Bool
onready var Enabled: CheckBox = $Save/Bool

func _ready() -> void:
	Bool.value = Index.edit_node.Autosave.time.wait_time
	Enabled.pressed = !Index.edit_node.Autosave.time.is_stopped()


func _on_Bool_value_changed(value: float) -> void:
	Index.edit_node.Autosave.time.wait_time = value


func _on_Bool_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Index.edit_node.Autosave.start(Bool.value)
