extends PanelContainer

signal create_thumbnail()

onready var Scroll: ScrollContainer = $Hbox/Info/Scroll
onready var Tiles: HFlowContainer = $Hbox/Info/Scroll/Tiles
onready var Tittle_node: Label = $Hbox/Info/Hbox/Tittle
onready var CreatePreview: Spatial = $Create_preview
onready var View: Viewport = $Create_preview/View
onready var Show_button: Button = $Hbox/Info/Hbox/Hide_and_show
onready var Id_button: CheckBox = $Hbox/Info/Hbox/Id
onready var Cam: Spatial = $Create_preview/View/Cam


var group_scene

var script_tile: Script = load("res://Script/Button_Tile.gd")

var tittle: String = "Basic Tile"

func _ready() -> void:
	
	Tittle_node.text = tittle
	
	generate_tile_button()
	emit_signal("create_thumbnail")


func get_tile(id_tile: int):
	for tile in group_scene.get_children():
		if tile.id_tile == id_tile:
			var new_tile = tile.duplicate()
			new_tile.id_tile = tile.id_tile
			new_tile.id_group = tile.id_group
			#new_tile.id = tile.id
			return new_tile
	
	return null


func generate_tile_button() -> void:
	for child in group_scene.get_children():
		yield(self,"create_thumbnail") #Generate to time
		
		var item_tile = TileButton.new()
		item_tile.set_script(script_tile)
		
		generate_icon(child,item_tile)
		
		item_tile.Tile = child
		Tiles.add_child(item_tile)


func generate_icon(mesh_ins: Tile,item_tile: TileButton) -> void:
	
	#Configure_button
	item_tile.expand_icon = true
	item_tile.rect_min_size = Vector2(60,60)
	
	#Instance preview
	
	var model_preview = mesh_ins.duplicate()
	CreatePreview.add_child(model_preview)
	model_preview.transform.origin = Vector3()
	#yield(get_tree().create_timer(0.2),"timeout")
	
	#Get view texture
	
	#Apply
	item_tile.set("icon", create_image())
	
	model_preview.call_deferred("queue_free")
	call_deferred("emit_signal","create_thumbnail")

func create_image() -> Texture:
	var view_data = View.get_texture().get_data()
	var texture = ImageTexture.new()
	texture.create_from_image(view_data)
	
	
	return texture


func _on_Id_pressed() -> void:
	for tilebutton in Tiles.get_children():
		tilebutton.id_text.visible = Id_button.pressed


func hide_vs() -> void:
	$Hbox/Vs.hide()
func show_vs() -> void:
	$Hbox/Vs.show()
	rect_min_size.x = 0
