extends PanelContainer

onready var Scroll: ScrollContainer = $Info/Scroll
onready var Tiles: HFlowContainer = $Info/Scroll/Tiles
onready var Tittle_node: Label = $Info/Hbox/Tittle

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
		var item_tile = TileButton.new()
		
		item_tile.set_script(script_tile)
		Tiles.add_child(item_tile)
		
		item_tile.Tile = child
		item_tile.text = child.name


func _on_Hide_and_show_pressed() -> void:
	visivel = !visivel
	
	if visivel:
		Scroll.rect_min_size.y = 200
	else:
		Scroll.rect_min_size.y = 0
		
