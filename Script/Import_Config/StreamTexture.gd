extends PanelContainer

onready var Tex: TextureButton = $Texture

func _on_Texture_pressed() -> void:
	IndexLayer.file_explore(
		["*.png","*.jpg","*.svg"],
		self,
		"confirm_path",
		"cancel",
		FileDialog.MODE_OPEN_FILE
	)

func confirm_path(dir,file_name) -> void:
	var image = Image.new()
	var image_tex = ImageTexture.new()
	
	image.load(dir)
	image_tex.create_from_image(image)
	
	Tex.texture_normal = image_tex
	
	get_parent().get_parent().get_parent().set_texture(image_tex)

