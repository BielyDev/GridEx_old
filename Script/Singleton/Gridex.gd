extends Node

func add_tile(id_tile: int,pos: Vector3 = Vector3(),rot: Vector3 = Vector3(),undo: bool = true) -> bool:
	return Index.block.add_block(pos*2,rot,id_tile,undo)

func clear() -> void:
	pass

func search_tile(id_group,id_tile,model: bool = false):
	for groups_tiles in Index.edit_node.Tile_groups.get_children():
		if id_group == groups_tiles.group_scene.id_group:
			for tiles in groups_tiles.Tiles.get_children():
				if tiles.Tile.id_tile == id_tile:
					if model:
						return tiles
					else:
						return tiles.Tile

