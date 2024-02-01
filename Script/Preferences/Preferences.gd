extends Control

signal OK()

onready var TextureButtonLoad: PanelContainer = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Background_texture/TextureLoadButton
onready var Opacity: HSlider = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Background_opacity/Opacity
onready var Edit_scale: OptionButton = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Background_edit/Edit_scale
onready var Size: HSlider = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Font_size/Size
onready var Border_size: HSlider = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Font_border_size/Border_size
onready var Border_color: ColorPickerButton = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Font_border/Font_border_color
onready var Save_node: Node = $"%Save"

var settings: Settings = Settings.new()


func _ready() -> void:
	Save_node.loader()
	UI.ready_animated_complex($Panel,$Background)
	
	edit_scale_ready()
	Size.value = settings.font_main.size
	Border_size.value = settings.font_main.outline_size
	Border_color.color = settings.font_main.outline_color
	Opacity.value = Index.edit_node.Background.modulate.a
	TextureButtonLoad.mat = Index.edit_node.Background_texture


func edit_scale_ready() -> void:
	match Index.edit_node.Background_texture.stretch_mode:
		0:
			Edit_scale.selected = 0
		2:
			Edit_scale.selected = 1
		6:
			Edit_scale.selected = 2





func _on_Theme_item_selected(_index: int) -> void:
	settings.theme_selection(_index)
	
	theme = Index.edit_node.Local.theme
	settings.settings["theme"] = _index


func _on_Opacity_value_changed(_value: float) -> void:
	settings.background_opacity(_value)
	settings.settings["background_opacity"] = _value

func _on_Option_item_selected(_index: int) -> void:
	settings.background_size_mode(_index)
	settings.settings["background_size"] = _index

func _on_Size_value_changed(_value: float) -> void:
	settings.font_size(_value)
	settings.settings["font_size"] = _value

func _on_Font_border_color_color_changed(_color: Color) -> void:
	settings.outline_font_color(_color)
	settings.settings["font_outline_color"] = _color

func _on_Border_size_value_changed(_value: float) -> void:
	settings.border_font_size(_value)
	settings.settings["font_outline_size"] = _value




func _on_Button_pressed() -> void:
	_exit()
func _on_Back_pressed() -> void:
	_exit()

func _exit() -> void:
	Save_node.save()
	yield(UI.queue_animated(self),"completed")
	emit_signal("OK")
