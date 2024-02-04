extends Node

onready var texture_load_button: TextureRect = $"../../Texture"

var settings = Settings.new()

func _ready() -> void:
	loader()

func loader() -> void:
	var file = File.new()
	
	if file.open(str(Index.system_path,"/settings.json"),File.READ) == OK:
		var arq = parse_json(file.get_as_text())
		
		file.close()
		
		#theme.select(arq.theme)
		
		var imagetex = ImageTexture.new()
		var image = Image.new()
		
		settings.font_size(arq.font_size)
		settings.outline_font_color(GridEx.string_to_color(arq.font_outline_color))
		
		image.load(arq.background_texture)
		imagetex.create_from_image(image)
		texture_load_button.texture = imagetex
		texture_load_button.texture.resource_path = arq.background_texture
		
		settings.call_deferred("theme_selection",arq["theme"])
		settings.call_deferred("background_opacity",arq["background_opacity"])
		settings.call_deferred("background_size_mode",arq["background_size"])


