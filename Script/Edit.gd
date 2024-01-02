extends CanvasLayer

var tile

onready var World3D = $World
onready var Edit: VBoxContainer = $Local/Vbox/Hbox/Edit
onready var View: ViewportContainer = $Local/Vbox/Hbox/View/ViewPanel/View

func _ready() -> void:
	World_ready()
	
	Index.edit_node = self


func World_ready() -> void:
	World3D.View = View
	World3D.Block.Option = $"%Option"
	World3D.Mirror = $"%Mirror"


func _on_Add_pressed() -> void:
	$Local/Vbox/Hbox/Edit/TileMain/Tab.current_tab = 0
