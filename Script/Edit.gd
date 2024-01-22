extends CanvasLayer

var tile
var popup_quit: bool = false


onready var World3D = $World
onready var Edit: VBoxContainer = $Local/Vbox/Hbox/Edit
onready var View: ViewportContainer = $Local/Vbox/Hbox/View/ViewPanel/View
onready var TexPanel := $Local/Vbox/Hbox/View/ViewPanel/Preview2D/Hbox/TexPanel
onready var Tile_groups: VBoxContainer = $"%Tile Groups"
onready var Node_2d: Node2D = $"2d"
onready var Local: MarginContainer = $Local
onready var Background: PanelContainer = $Background
onready var Background_texture: TextureRect = $Texture


func _ready() -> void:
	Index.edit_node = self
	IndexLayer.connect("theme",self,"theme_changed")
	
	World_ready()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		if popup_quit:
			quit_confirm()
		
		IndexLayer.popup_two("Do you really want to leave?",self,"quit_confirm","cancel")
		popup_quit = true


func theme_changed(tema: Theme) -> void:
	Local.theme = tema
	Background.theme = tema

func World_ready() -> void:
	World3D.View = View
	World3D.Block.Option = $"%Option"
	World3D.Mirror = $"%Mirror"


func quit_confirm() -> void:
	get_tree().quit()
func cancel() -> void:
	popup_quit = false

func _on_Add_pressed() -> void:
	TexPanel.show()
	$Local/Vbox/Hbox/Edit/TileMain/Tab.current_tab = 0


func _on_Light_pressed() -> void:
	TexPanel.hide()

func _on_Void_pressed() -> void:
	TexPanel.hide()

