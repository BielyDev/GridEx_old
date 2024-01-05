extends PanelContainer

onready var Scroll: ScrollContainer = $Info/Scroll
onready var Tiles: HFlowContainer = $Info/Scroll/Tiles
onready var Tittle_node: Label = $Info/Hbox/Tittle
onready var CreatePreview: Spatial = $Create_preview
onready var View: Viewport = $Create_preview/View

export(PackedScene) var group_scene: PackedScene

var tittle: String = "Basic Tile"
var script_tile: Script = load("res://Script/Button_Tile.gd")
var visivel: bool = true

func _ready() -> void:
	Tittle_node.text = tittle
	
	generate_tile_button()


func generate_tile_button() -> void:
	var scene_tile = group_scene.instance()
	
	for child in scene_tile.get_children():
		yield(get_tree().create_timer(0.2),"timeout") #Generate to time
		
		var item_tile = TileButton.new()
		item_tile.set_script(script_tile)
		
		generate_icon(child,item_tile)
		
		Tiles.add_child(item_tile)
		
		item_tile.Tile = child


func generate_icon(mesh_ins: MeshInstance,item_tile: TileButton) -> void:
	#Configure_button
	item_tile.expand_icon = true
	item_tile.rect_min_size = Vector2(60,60)
	
	#Instance preview
	var model_preview = mesh_ins.duplicate()
	CreatePreview.add_child(model_preview)
	model_preview.transform.origin = Vector3()
	yield(get_tree().create_timer(0.2),"timeout")
	#Get view texture
	var view_data = View.get_texture().get_data()
	var texture = ImageTexture.new()
	texture.create_from_image(view_data)
	
	#Apply
	item_tile.icon = texture
	model_preview.queue_free()


func _on_Hide_and_show_pressed() -> void:
	visivel = !visivel
	
	if visivel:
		Scroll.rect_min_size.y = 200
	else:
		Scroll.rect_min_size.y = 0
