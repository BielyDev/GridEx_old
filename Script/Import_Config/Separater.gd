extends Control

export(String) var Propriety_name: String

var separator: Vector3
var global_scale: Vector3 = Vector3(1,1,1)
var global_movement: Vector3

onready var Propriety: VBoxContainer = $Propriety/Vbox
onready var Models: Spatial = $"%Models"
onready var Vector: VBoxContainer = $Propriety/Vbox/Vector

func _ready() -> void:
	Vector.node = self
	Vector.propriety = Propriety_name


func _on_Separater_pressed() -> void:
	show()
func _on_Global_scaled_pressed() -> void:
	show()
func _on_Global_movement_pressed() -> void:
	show()

func _on_Button_pressed() -> void:
	var sep = separator
	for groups in Models.get_children():
		for childs in groups.get_children():
			childs.transform.origin = sep
			sep += separator
	hide()


func _on_Close_pressed() -> void:
	hide()


func _on_Apply_Scale_pressed() -> void:
	for groups in Models.get_children():
		for childs in groups.get_children():
			childs.scale = global_scale
	hide()




func _on_Apply_Movement_pressed() -> void:
	for groups in Models.get_children():
		for childs in groups.get_children():
			childs.transform.origin += global_movement
	hide()


