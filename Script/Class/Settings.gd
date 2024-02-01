extends GridEx

class_name Settings

enum THEMES {GRIDEX,GRIDEX_ALPHA,GODOT,ROSE_DARK,ALIEN}

var new_main: Theme = preload("res://Assets/Theme/New_main.tres")
var dark: Theme = preload("res://Assets/Theme/Dark.tres")
var rose_dark: Theme = preload("res://Assets/Theme/Rose_Dark.tres")
var alien: Theme = preload("res://Assets/Theme/Alien.tres")
var godot: Theme = preload("res://Assets/Theme/Godot.tres")
var font_main = preload("res://Assets/Font/Tres/fontmain.tres")


var settings = {
	"glow_enabled": false,
	"adjustment_enabled": false,
	"fog_enabled": false,
	"ss_reflections_enabled": false,
	"background_texture": "",
	"background_opacity": 1,
	"theme": 0,
	"font_outline_size": 0,
	"font_size": 18,
	"font_outline_color": "1,1,1,1",
	"0": 50,
	"1": 50
}


func theme_selection(value: int) -> void:
	match value:
		THEMES.GRIDEX:
			IndexLayer.theme_changed(new_main)
		THEMES.GRIDEX_ALPHA:
			IndexLayer.theme_changed(dark)
		THEMES.GODOT:
			IndexLayer.theme_changed(godot)
		THEMES.ROSE_DARK:
			IndexLayer.theme_changed(rose_dark)
		THEMES.ALIEN:
			IndexLayer.theme_changed(alien)


func background_size_mode(value: int) -> void:
	match value:
		0:
			Index.edit_node.Background_texture.stretch_mode = 0
		1:
			Index.edit_node.Background_texture.stretch_mode = 2
		2:
			Index.edit_node.Background_texture.stretch_mode = 6


func font_size(value: int) -> void:
	font_main.size = value

func outline_font_color(color: Color) -> void:
	font_main.outline_color = color

func border_font_size(_value: int) -> void:
	font_main.outline_size = _value

func background_opacity(_value: float) -> void:
	Index.edit_node.Background.modulate.a = _value

