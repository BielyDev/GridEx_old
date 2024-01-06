extends Control

#var 
var LightConfig: OmniLight
onready var Energy_value: SpinBox = $LightPanel/Vbox/Panel/Vbox/Energy/Value
onready var Size_value: SpinBox = $LightPanel/Vbox/Panel/Vbox/Size/Value
onready var Att_value: SpinBox = $LightPanel/Vbox/Panel/Vbox/Attenuation/Value
onready var Shadowns: CheckBox = $LightPanel/Vbox/Panel/Vbox/View/Vbox/ColorPanel/Vbox/Shadowns/Vbox/Value
onready var ShadownsColor: ColorPickerButton = $LightPanel/Vbox/Panel/Vbox/View/Vbox/ColorPanel/Vbox/ShadownsColor/Vbox/Value
onready var Lightcolor: ColorPickerButton = $LightPanel/Vbox/Panel/Vbox/View/Vbox/ColorPanel/Vbox/Color

func sets() -> void:
	Energy_value.No = LightConfig
	Size_value.No = LightConfig
	Att_value.No = LightConfig
	Shadowns.No = LightConfig
	ShadownsColor.No = LightConfig
	Lightcolor.No = LightConfig

func _ready() -> void:
	Index.block_view = true
	
	Energy_value.No = LightConfig
	Size_value.No = LightConfig
	Att_value.No = LightConfig
	Shadowns.No = LightConfig
	ShadownsColor.No = LightConfig
	Lightcolor.No = LightConfig


func _on_Ok_pressed() -> void:
	Index.block_view = false
	queue_free()
