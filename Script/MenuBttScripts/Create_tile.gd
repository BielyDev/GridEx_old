extends Node

signal finished()


func start() -> void:
	Index.block_view = true
	Index.edit_node.View.hide()
	Index.edit_node.World3D.hide()
	Index.edit_node.View.get_child(0).get_child(0).hide()
	
	IndexLayer.importer_menu(
		self,
		"ok"
	)

func ok():
	Index.edit_node.View.show()
	Index.edit_node.View.get_child(0).get_child(0).show()
	Index.edit_node.World3D.show()
	
	emit_signal("finished")
	Index.block_view = false
