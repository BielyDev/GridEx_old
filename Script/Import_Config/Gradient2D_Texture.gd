extends PanelContainer

signal texture_chaged(texture)

onready var Controls: Control = $Vbox/Gradient/Tex/Controls
onready var GradTex: TextureButton = $Vbox/Gradient/Tex
onready var Color_Control := $Vbox/Gradient/Tex/Controls/Color_Control.duplicate()
onready var Texture_node: TextureRect = $Vbox/GradientTexture/Text
onready var Points: Control = $Vbox/GradientTexture/Points

var gradient2d: GradientTexture2D = GradientTexture2D.new()
var gradienttexture: GradientTexture = GradientTexture.new()
var gradient: Gradient = Gradient.new()
var tex_ready


func _ready() -> void:
	
	if tex_ready != null:
		gradient2d = tex_ready
		gradient = gradient2d.gradient
	
	gradient2d.gradient = gradient
	gradienttexture.gradient = gradient
	Texture_node.texture = gradient2d
	GradTex.texture_normal = gradienttexture
	
	loader_texture()
	
	emit_signal("texture_chaged",gradient2d)

func filter(value:bool) -> void:
	if value:
		gradient2d.flags = ImageTexture.FLAG_FILTER
	else:
		gradient2d.flags = ImageTexture.FLAG_MIPMAPS
	
	emit_signal("texture_chaged",gradient2d)

func loader_texture() -> void:
	if tex_ready != null:
		Controls.get_child(0).queue_free()
		_on_Fill_item_selected(gradient2d.fill)
		
		for offsets in range (gradient.offsets.size()):
			var button = add_button_color(offsets)
			button.rect_position.x = gradient.offsets[offsets] * 150
			button.get_child(1).color = gradient.colors[offsets]
		
		Points.get_child(0).position = gradient2d.fill_from * 150
		Points.get_child(1).position = gradient2d.fill_to * 150
	
	else:
		add_button_color(1).rect_position.x = 150


func add_button_color(id: int = 0) -> Control:
	var new_button: Control = Color_Control.duplicate()
	
	new_button.get_child(1).id = id
	new_button.get_child(1).color = gradient.colors[id]
	
	Controls.add_child(new_button)
	
	return new_button


func _on_Tex_pressed() -> void:
	#gradient.add_point(GradTex.get_local_mouse_position().x * 0.004096,Color(1,1,1))
	pass
	#add_button_color(gradient.colors.size()-1).rect_position.x = GradTex.get_local_mouse_position().x



func _on_Fill_item_selected(_index: int) -> void:
	match _index:
		0:
			gradient2d.fill = GradientTexture2D.FILL_LINEAR
		1:
			gradient2d.fill = GradientTexture2D.FILL_RADIAL
