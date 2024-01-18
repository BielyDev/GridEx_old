extends PanelContainer

signal texture_chaged(texture)

onready var Controls: Control = $Vbox/Gradient/Tex/Controls
onready var GradTex: TextureButton = $Vbox/Gradient/Tex
onready var Color_Control: ColorPickerButton = $Vbox/Gradient/Tex/Controls/Color_Control
onready var Texture_node: TextureRect = $Vbox/GradientTexture/Text

var gradient2d: GradientTexture2D = GradientTexture2D.new()
var gradienttexture: GradientTexture = GradientTexture.new()
var gradient: Gradient = Gradient.new()

func _ready() -> void:
	gradient2d.gradient = gradient
	gradienttexture.gradient = gradient
	Texture_node.texture = gradient2d
	GradTex.texture_normal = gradienttexture
	
	add_button_color(1).rect_position.x = 244
	
	emit_signal("texture_chaged",gradient2d)

func add_button_color(id: int = 0) -> ColorPickerButton:
	var new_button: ColorPickerButton = Color_Control.duplicate()
	
	new_button.id = id
	new_button.color = gradient.get_color(id)
	
	Controls.add_child(new_button)
	
	return new_button


func _on_Tex_pressed() -> void:
	gradient.add_point(GradTex.get_local_mouse_position().x * 0.004096,Color(1,1,1))
	
	add_button_color(gradient.colors.size()-1).rect_position.x = GradTex.get_local_mouse_position().x
