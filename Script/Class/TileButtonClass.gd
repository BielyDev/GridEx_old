extends AnimationButtonClass

class_name TileButton


var Up: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Up.tres")
var Reload: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Reload_icon_tile.tres")


var Tile: Tile
var id_text = Label.new()
var popup = true
var new_popup

func _ready() -> void:
	connect("gui_input",self,"_settings_popup")
	connect("child_exiting_tree",self,"reset_pop")
	
	
	center_pivot()
	speed = 0.2
	
	add_child(id_text)
	id_text.hide()
	id_text.text =  str(Tile.id_tile)

func index() -> void:
	Index.tile.id_tile = Tile.id_tile
	Index.tile.id_group = Tile.id_group
	Index.tile.icon = icon


func _settings_popup(_event: InputEvent) -> void:
	if _event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_RIGHT) and popup:
			grab_focus()
			
			new_popup = GridEx.new_settings_popup()
			add_child(new_popup)
			buttons_popup(new_popup)
			popup = false


func reset_pop(child: Node) -> void:
	popup = true


func buttons_popup(popup: CanvasLayer) -> void:
	popup.create_button(self,"First tile","first_tile",Up)
	popup.create_button(self,"Reload icon","reload_icon",Reload)

func first_tile() -> void:
	get_parent().move_child(self,0)
	new_popup.hide()

func reload_icon() -> void:
	get_parent().get_parent().get_parent().get_parent().get_parent().generate_icon(Tile,self,5)
	new_popup.hide()
