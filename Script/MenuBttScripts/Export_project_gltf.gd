extends Node

signal finished()

func start() -> void:
	Index.block_view = true
	
	Index.edit_node.file_explore(
		["*.gltf"],
		self,
		"ok",
		"cancel"
	)

func ok(dir):
	Index.edit_node.World3D.export_scene_gltf(str(dir,".gltf"))
	emit_signal("finished")
	Index.block_view = false

func cancel():
	emit_signal("finished")
	Index.block_view = false
