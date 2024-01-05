extends Node

onready var Par: Control = $".."


func save_groups(path,file):
	for child in Par.Models.get_children():
		var group_scene = PackedScene.new()
		group_scene.pack(child)
		yield(get_tree().create_timer(1),"timeout")
		
		var file_name = str(path,child.name,".tscn")
		
		var erro = ResourceSaver.save(file_name,group_scene)
		
		Import.import_group_tile_automatic(file_name)
		
		yield(UI.queue_animated(Par),"completed")
		emit_signal("OK")



