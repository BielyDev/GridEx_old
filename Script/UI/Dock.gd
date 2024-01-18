extends TabContainer

func _ready() -> void:
	drag_to_rearrange_enabled = true
	set_tabs_rearrange_group(0)
	
	connect("child_exiting_tree",self,"_child_exit")
	connect("child_entered_tree",self,"_child_show")


func _child_exit(node: Node):
	if get_child_count() == 1:
		rect_min_size.x = 0
func _child_show(node: Node):
	if get_child_count() == 0:
		rect_min_size.x = 400
