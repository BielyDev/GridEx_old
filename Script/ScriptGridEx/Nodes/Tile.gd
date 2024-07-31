extends Node

var item = {id_group = 0,id_tile = 0}

onready var groups_option: OptionButton = $"../Panel/Hbox/Info/Groups"
onready var tile_option: OptionButton = $"../Panel/Hbox/Info/Tile"
onready var tile: GraphNode = $".."
onready var icon_tile: TextureRect = $"../Panel/Hbox/IconTile"

var groups_id: Array = []

func search_item() -> void:
	tile.value = item
	icon_tile.texture = tile_option.get_item_icon(item.id_tile)


func _on_Groups_item_selected(index: int) -> void:
	item.id_group = groups_id[index]
	search_item()

func _on_Tile_item_selected(index: int) -> void:
	item.id_tile = index
	search_item()

func _ready() -> void:
	for groups_tiles in Index.edit_node.Tile_groups.get_children():
		groups_option.add_item(groups_tiles.tittle,groups_tiles.group_scene.id_group)
		groups_id.append(groups_tiles.group_scene.id_group)
		
		for tiles in groups_tiles.Tiles.get_children():
			yield(get_tree().create_timer(0.2),"timeout")
			tile_option.add_icon_item(tiles.icon,str(tiles.Tile.id_tile),tiles.Tile.id_tile)
	
	item.id_group = groups_id[0]


