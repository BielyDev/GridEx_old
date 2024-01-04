extends Node

onready var Par: Control = $".."

var basic_tile_new: PackedScene = preload("res://Scene/Theme_Tile/Basic.tscn")

func save_groups(path,file):
	for child in Par.Models.get_children():
		var group_scene = PackedScene.new()
		group_scene.pack(child)
		yield(get_tree().create_timer(1),"timeout")
		
		var file_name = str(path,child.name,".tscn")
		
		var erro = ResourceSaver.save(file_name,group_scene)
		print(file_name)
		
		import_group_tile_automatic(file_name)
		
		yield(UI.queue_animated(Par),"completed")
		emit_signal("OK")


func import_group_tile_automatic(file_name) -> void:
	
	var scene = load(file_name)
	var no = scene.instance()
	
	var basic = basic_tile_new.instance()
	
	basic.tittle = no.name
	basic.group_scene = scene
	Index.edit_node.Tile_groups.add_child(basic)

