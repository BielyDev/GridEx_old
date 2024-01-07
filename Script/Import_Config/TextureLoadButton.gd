extends PanelContainer

onready var Tex: VBoxContainer = $Vbox/Textures
onready var Options: MenuButton = $Vbox/Options

var StreamTexture_new: PackedScene = preload("res://Scene/Import/StreamTexture.tscn")

var mat: SpatialMaterial

func clear() -> void:
	for child in Tex.get_children():
		mat.albedo_texture = null
		child.queue_free()

func stream() -> void:
	clear()
	
	var stream_add = StreamTexture_new.instance()
	
	Tex.add_child(stream_add)

func set_texture(texture) -> void:
	mat.albedo_texture = texture
