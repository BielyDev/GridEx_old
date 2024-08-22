extends Spatial

signal tile_added()

enum MODE {REPLACE,STOP,MIX,JUST_UP}


onready var Anima: AnimationPlayer = $"../Selection3D/Anima"
onready var World_node: Spatial = $".."

var Option: OptionButton

var block_pos: Array = []
var mode: int = 0
var delete_select: bool = false


func _ready() -> void:
	Index.block = self
	
	yield(get_tree().create_timer(0.5),"timeout")
	Option.connect("item_selected",self,"mode_selected")
	
	if get_child_count() == 0:
		var new_layer = Spatial.new()
		
		new_layer.name = "Layer 0"
		add_child(new_layer)
		
		Index.layer_select = 0



func add_block(pos: Vector3,rot: Vector3,id_tile: int,undo: bool = true) -> bool:
	match mode:
		MODE.REPLACE:
			_replace(pos,rot,id_tile,undo)
		MODE.STOP:
			if _stop(pos,rot,id_tile,undo) == false: return false
		MODE.MIX:
			_mix(pos,rot,id_tile,undo)
		MODE.JUST_UP:
			_just_up(pos,rot,id_tile,undo)
	return true


func remove_block(pos: Vector3,undo: bool = true) -> void:
	loop_get_tile(self,pos,undo)


func instance_block(id_tile: int,pos_in: Vector3,rot: Vector3,undo: bool,undo_type: int = Index.UNDOTYPE.ADD) -> void:
	#Search_tile================================================================
	var tile
	
	for groups_tiles in Index.edit_node.Tile_groups.get_children():
		if Index.tile.id_group == groups_tiles.group_scene.id_group:
			tile = groups_tiles.get_tile(id_tile)
	
	if tile == null:
		print("null selection")
		return
	#===========================================================================
	
	_started_layer() # Caso não exista layer para por tiles
	
	#Tile settings==============================================================
	get_child(Index.layer_select).add_child(tile)
	
	
	tile.global_position = pos_in
	tile.rotation_degrees = rot
	
	block_pos.push_back({pos = pos_in, tile = tile})
	#===========================================================================
	
	
	#Additional=================================================================
	if undo:
		World_node.undo_local.append({pos = pos_in,rot = rot,type = Index.UNDOTYPE.ADD,tile = tile.id_tile}) #Index.undo.append({pos = pos_in,add = true,tile = tile})
	
	emit_signal("tile_added")
	
	Anima.stop()
	Anima.play("Add")
	#===========================================================================


func delete_block(tile,pos,undo) -> bool:
	var tile_undo
	var rot = tile.rotation_degrees
	var id_tile = tile.id_tile
	
	if tile != null:
		
		if verific_is_layer(tile) == false:
			return false
		
		tile.queue_free()
		
		if delete_select:
			var dic = {pos = pos,tile = Index.tile.tile}
			block_pos.erase(dic)
		else:
			for block in block_pos:
				if block.pos == Index.block.get_child(Index.layer_select).to_local(pos):
					
					var dic = {pos = pos,tile = block.tile}
					
					block_pos.erase(dic)
					tile_undo = block.tile
		
		if undo: World_node.undo_local.append({pos = pos,rot = rot,type = Index.UNDOTYPE.REMOVE,tile = id_tile})
		
		Anima.stop()
		Anima.play("Remove")
		return true
	
	return false



func verific_is_layer(tile: Tile) -> bool:
	for search in Index.block.get_child(Index.layer_select).get_children():
		if search == tile:
			return true
	
	return false

func loop_get_tile(node,pos: Vector3,undo):
	for pos_array in node.get_children():
		if pos_array.get_child_count() >= 1:
			if pos_array is OmniLight:
				if pos_array.global_position == pos:
					delete_block(pos_array,pos,undo)
			else:
				loop_get_tile(pos_array,pos,undo)
		else:
			if pos_array.global_position == pos:
				delete_block(pos_array,pos,undo)

func _started_layer() -> void:
	if get_child_count() == 0:
		var new_layer = Spatial.new()
		
		new_layer.name = "Layer 0"
		add_child(new_layer)
		
		Index.layer_select = 0

func mode_selected(index: int) -> void:
	mode = index




#Functions Mode =========
func _replace(pos: Vector3,rot: Vector3,id_tile: int,undo: bool = true) -> void:
	
	for blocos in get_child(Index.layer_select).get_children():
		if blocos.global_position == pos:
			delete_block(blocos,blocos.global_position,undo)
	
	call_deferred("instance_block",id_tile,pos,rot,undo)

func _stop(pos: Vector3,rot: Vector3,id_tile: int,undo: bool = true) -> bool:
	for pos_array in block_pos:
		if pos_array.pos == pos:
			return false
	
	instance_block(id_tile,pos,rot,undo)
	return true
func _just_up(pos: Vector3,rot: Vector3,id_tile: int,undo: bool = true) -> void:
	for blocos in get_child(Index.layer_select).get_children():
		if blocos.global_position == pos:
			blocos.queue_free()
			block_pos.erase(pos)
			
			instance_block(id_tile,pos,rot,undo,Index.UNDOTYPE.SET)
func _mix(pos: Vector3,rot: Vector3,id_tile: int,undo: bool = true) -> void:
	instance_block(id_tile,pos,rot,undo)

