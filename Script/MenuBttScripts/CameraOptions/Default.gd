extends Node

signal finished()

func start() -> void:
	Index.view2d.viewport.debug_draw = Viewport.DEBUG_DRAW_DISABLED
	
	emit_signal("finished")
