extends Node

signal finished()

func start() -> void:
	Index.view2d.preview2d.visible = !Index.view2d.preview2d.visible
	get_parent().get_popup().set_item_checked(0,Index.view2d.preview2d.visible)
	emit_signal("finished")
