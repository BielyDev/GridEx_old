extends Node

onready var theme: OptionButton = $"../Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Theme_color/Theme"
onready var texture_load_button: PanelContainer = $"../Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Background_texture/TextureLoadButton"
onready var border_size: HSlider = $"../Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Font_border_size/Border_size"
onready var font_border_color: ColorPickerButton = $"../Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Font_border/Font_border_color"
onready var opacity: HSlider = $"../Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Background_opacity/Opacity"
onready var edit_scale: OptionButton = $"../Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Background_edit/Edit_scale"
onready var resolutions_options: HBoxContainer = $"../Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Viewport/Resolution"
onready var preferences: Control = $".."



func save() -> void:
	preferences.settings.settings["background_texture"] = Index.edit_node.Background_texture.texture.resource_path
	
	var file = File.new()
	
	file.open(str(Index.system_path,"/settings.json"),File.WRITE)
	file.store_line(JSON.print(preferences.settings.settings,"	"))
	
	
	file.close()


func loader() -> void:
	var file = File.new()
	
	if file.open(str(Index.system_path,"/settings.json"),File.READ) == OK:
		var arq = parse_json(file.get_as_text())
		
		file.close()
		
		preferences.settings.settings = arq
		theme.select(arq.theme)
		border_size.value = arq.font_outline_size
		edit_scale.select(arq.background_size)
		font_border_color.color = arq.font_outline_color
		opacity.value = arq.background_opacity
		opacity.value = arq.background_opacity
		resolutions_options.get_child(1).selected = arq.resolution
		resolutions_options._on_Resolutions_options_item_selected(arq.resolution)
		#border_size.value = arq.font_outline_size
