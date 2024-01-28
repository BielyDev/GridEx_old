extends Node

signal finished()

func start() -> void:
	Index.view2d.axis.visible = !Index.view2d.axis.visible
	get_parent().get_popup().set_item_checked(1,Index.view2d.axis.visible)
	emit_signal("finished")
