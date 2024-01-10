extends PanelContainer

signal texture_chaged(texture)

onready var Tex: TextureButton = $Texture

var tex_ready

func _ready() -> void:
	Tex.texture_normal = tex_ready

func _on_Texture_pressed() -> void:
	IndexLayer.file_explore(
		["*.png","*.jpg","*.jpeg","*.svg"],
		self,
		"confirm_path",
		"cancel",
		FileDialog.MODE_OPEN_FILE
	)

func confirm_path(dir: String,file_name: String) -> void:
	var image = Image.new()
	var image_tex = ImageTexture.new()
	
	image.load(dir)
	image_tex.create_from_image(image)
	
	Tex.texture_normal = image_tex
	
	emit_signal("texture_chaged",image_tex)

