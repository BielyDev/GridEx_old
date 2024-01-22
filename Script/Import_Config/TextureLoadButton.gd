extends PanelContainer

onready var Tex: VBoxContainer = $Vbox/Textures
onready var Options: MenuButton = $Vbox/Options

export(String) var propriety_value: String = "texture"

var StreamTexture_new: PackedScene = preload("res://Scene/Import/StreamTexture.tscn")
var AnimatedTexture_new: PackedScene = preload("res://Scene/Import/AnimatedTexture.tscn")
var GradientTexture_new: PackedScene = preload("res://Scene/Import/Gradient2D_Texture.tscn")

var texture
var stream: bool = true

var mat
var mat_propriety: String

func _ready() -> void:
	yield(get_tree().create_timer(0.2),"timeout")
	
	loader_texture()


func loader_texture():
	
	var value = mat.get(propriety_value)
	if mat is SpatialMaterial:
		value = mat.albedo_texture
	
	if value is ImageTexture:
		stream(value)
	
	if value is AnimatedTexture:
		animated(value)
	
	if value is GradientTexture2D:
		gradient(value)
	
	if texture != null:
		call_deferred("ready_texture")

func ready_texture() -> void:
	if mat is SpatialMaterial:
		texture.tex_ready = mat.albedo_texture
	else:
		texture.tex_ready = mat.get(propriety_value)


func clear() -> void:
	for child in Tex.get_children():
		if mat is SpatialMaterial:
			mat.albedo_texture = null
		else:
			mat.set(propriety_value,null)
		
		child.queue_free()


func stream(_ready = null) -> void:
	clear()
	texture = StreamTexture_new.instance()
	texture.tex_ready = _ready
	
	texture.connect("texture_chaged",self,"set_texture")
	Tex.add_child(texture)
	Options.text = "[Stream Texture]"

func animated(_ready = null) -> void:
	clear()
	texture = AnimatedTexture_new.instance()
	texture.tex_ready = _ready
	
	texture.connect("texture_chaged",self,"set_texture")
	Tex.add_child(texture)
	Options.text = "[Animated Texture]"

func gradient(_ready = null) -> void:
	clear()
	texture = GradientTexture_new.instance()
	texture.tex_ready = _ready
	
	texture.connect("texture_chaged",self,"set_texture")
	Tex.add_child(texture)
	Options.text = "[Gradient2D Texture]"

func set_texture(texture) -> void:
	if mat is SpatialMaterial:
		mat.albedo_texture = texture
	else:
		mat.set(propriety_value,texture)

