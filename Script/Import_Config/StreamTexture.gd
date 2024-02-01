extends PanelContainer

signal texture_chaged(texture)

onready var Tex: TextureButton = $Texture

var tex_ready: Texture
var image = Image.new()
var image_tex = ImageTexture.new()

func _ready() -> void:
	if tex_ready != null:
		Tex.texture_normal = tex_ready
		image_tex = tex_ready
		$Tittle.text = tex_ready.resource_path

func filter(value:bool) -> void:
	if value:
		image_tex.flags = ImageTexture.FLAG_REPEAT
	else:
		image_tex.flags = ImageTexture.FLAGS_DEFAULT
	
	emit_signal("texture_chaged",image_tex)

func _on_Texture_pressed() -> void:
	IndexLayer.file_explore(
		["*.png","*.jpg","*.jpeg","*.svg"],
		self,
		"confirm_path",
		"cancel",
		FileDialog.MODE_OPEN_FILE
	)

func confirm_path(dir: String,file_name: String) -> void:
	if (dir.get_extension() == "png" or dir.get_extension() == "jpg" or  dir.get_extension() == "jpeg" or  dir.get_extension() == "svg") == false:
		IndexLayer.popup_one('The file type must be "png / jpg / jpeg / svg"!')
		return
	
	image.load(dir)
	image_tex.create_from_image(image)
	image_tex.resource_path = dir
	
	Tex.texture_normal = image_tex
	
	$Tittle.text = dir.get_file()
	
	emit_signal("texture_chaged",image_tex)

