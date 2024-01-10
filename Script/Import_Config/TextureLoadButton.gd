extends PanelContainer

onready var Tex: VBoxContainer = $Vbox/Textures
onready var Options: MenuButton = $Vbox/Options

var StreamTexture_new: PackedScene = preload("res://Scene/Import/StreamTexture.tscn")
var AnimatedTexture_new: PackedScene = preload("res://Scene/Import/AnimatedTexture.tscn")

var texture
var stream: bool = true

var mat: SpatialMaterial
var mat_propriety: String

func _ready() -> void:
	var value = mat.get(mat_propriety)
	stream == value is StreamTexture
	
	if stream:
		texture = StreamTexture_new.instance()
		if texture.tex_ready != null:
			stream()
	else:
		texture = AnimatedTexture_new.instance()
	
	texture.tex_ready = value



func clear() -> void:
	for child in Tex.get_children():
		mat.albedo_texture = null
		child.queue_free()


func stream() -> void:
	clear()
	texture = StreamTexture_new.instance()
	
	texture.connect("texture_chaged",self,"set_texture")
	Tex.add_child(texture)

func animated() -> void:
	clear()
	texture = AnimatedTexture_new.instance()
	
	texture.connect("texture_chaged",self,"set_texture")
	Tex.add_child(texture)

func set_texture(texture) -> void:
	mat.albedo_texture = texture

