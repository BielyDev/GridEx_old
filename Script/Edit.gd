extends CanvasLayer

var tile

onready var World3D = $World
onready var Edit: VBoxContainer = $Local/Vbox/Hbox/Edit
onready var View: ViewportContainer = $Local/Vbox/Hbox/View/ViewPanel/View
onready var TexPanel := $Local/Vbox/Hbox/View/ViewPanel/Preview2D/Hbox/TexPanel
onready var Tile_groups: VBoxContainer = $"%Tile Groups"


func _ready() -> void:
	World_ready()
	Index.edit_node = self


func World_ready() -> void:
	World3D.View = View
	World3D.Block.Option = $"%Option"
	World3D.Mirror = $"%Mirror"


func _on_Add_pressed() -> void:
	TexPanel.show()
	$Local/Vbox/Hbox/Edit/TileMain/Tab.current_tab = 0


func _on_Light_pressed() -> void:
	TexPanel.hide()

func _on_Void_pressed() -> void:
	TexPanel.hide()

