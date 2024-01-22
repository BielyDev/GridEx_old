extends Control

signal OK()

onready var TextureButtonLoad: PanelContainer = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Background_texture/TextureLoadButton
onready var Opacity: HSlider = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Background_opacity/Opacity
onready var Edit_scale: OptionButton = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Background_edit/Edit_scale
onready var Size: HSlider = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Font_size/Size
onready var Border_size: HSlider = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Font_border_size/Border_size
onready var Border_color: ColorPickerButton = $Panel/Vbox/Hbox/Propriety/Scroll/Propriety/Theme/Font_border/Font_border_color


var new_main: Theme = preload("res://Assets/Theme/New_main.tres")
var dark: Theme = preload("res://Assets/Theme/Dark.tres")
var rose_dark: Theme = preload("res://Assets/Theme/Rose_Dark.tres")
var rose_light: Theme = preload("res://Assets/Theme/Rose_Light.tres")
var godot: Theme = preload("res://Assets/Theme/Godot.tres")
var font_main = preload("res://Assets/Font/Tres/fontmain.tres")

func _ready() -> void:
	UI.ready_animated_complex($Panel,$Background)
	
	edit_scale_ready()
	Size.value = font_main.size
	Border_size.value = font_main.outline_size
	Border_color.color = font_main.outline_color
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
	match _index:
		0:
			IndexLayer.theme_changed(new_main)
		1:
			IndexLayer.theme_changed(dark)
		2:
			IndexLayer.theme_changed(godot)
		3:
			IndexLayer.theme_changed(rose_dark)
		4:
			IndexLayer.theme_changed(rose_light)
	
	theme = Index.edit_node.Local.theme


func _on_Opacity_value_changed(_value: float) -> void:
	Index.edit_node.Background.modulate.a = _value


func _on_Option_item_selected(_index: int) -> void:
	match _index:
		0:
			Index.edit_node.Background_texture.stretch_mode = 0
		1:
			Index.edit_node.Background_texture.stretch_mode = 2
		2:
			Index.edit_node.Background_texture.stretch_mode = 6


func _on_Size_value_changed(_value: float) -> void:
	font_main.size = _value
func _on_Font_border_color_color_changed(_color: Color) -> void:
	font_main.outline_color = _color
func _on_Border_size_value_changed(_value: float) -> void:
	font_main.outline_size = _value

func _on_Button_pressed() -> void:
	yield(UI.queue_animated(self),"completed")
	emit_signal("OK")
func _on_Back_pressed() -> void:
	yield(UI.queue_animated(self),"completed")
	emit_signal("OK")
