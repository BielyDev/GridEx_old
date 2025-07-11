extends TabContainer

export(String) var value_id: String

export(bool) var Expand_x: bool = false
export(bool) var Expand_y: bool = false
export(bool) var An_one: bool = false
export(int) var parents: int = -1
export(String) var call_func_enter: String
export(String) var call_func_exit: String


func _ready() -> void:
	drag_to_rearrange_enabled = true
	set_tabs_rearrange_group(0)
	
	connect("child_exiting_tree",self,"_child_exit")
	connect("child_entered_tree",self,"_child_show")
	
	if parents != -1:call_deferred("expand",true)


func _child_exit(node: Node):
	if node.name == "Empty_window":
		if get_child_count() == 1:
			node.queue_free()
			yield(get_tree(),"idle_frame")
			empty_instance()
		return
	
	yield(get_tree().create_timer(0.1),"timeout")
	
	if parents != 0:call("expand",false)
	
	if get_child_count() == 0:
		empty_instance()


func empty_instance() -> void:
		var new_win = Index.window_empty.instance()
		add_child(new_win)
		
		rect_min_size.x = 0
		rect_min_size.y = 0
		rect_size.x = 0
		rect_size.y = 0


func _child_show(node: Node):
	if node.name == "Empty_window":
		return
	
	for child in get_children():
		if child.name == "Empty_window":
			child.queue_free()
	
	yield(get_tree().create_timer(0.1),"timeout")
	
	if get_child_count() == 1:
		rect_min_size.x = 200
		rect_min_size.y = 200
	
	if parents != -1:call_deferred("expand",true)



func expand(enter: bool) -> void:
	var get_parent = self
	
	
	for parent in range(parents):
		if get_parent.get_child_count() != 0:
			get_parent = get_parent.get_child(0)
	
	
	for child in get_parent.get_children():
		if child.get(value_id) == null:
			return
		
		if Expand_x:
			child.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			var rect = child.rect_size
			if An_one:
				child.size_flags_horizontal = Control.SIZE_FILL
				child.rect_min_size = rect
		else:
			child.size_flags_horizontal = Control.SIZE_FILL
			child.rect_min_size.x = 0
		
		
		if Expand_y:
			child.size_flags_vertical = Control.SIZE_EXPAND_FILL
			if An_one:
				child.size_flags_vertical = Control.SIZE_FILL
		else:
			child.size_flags_vertical = Control.SIZE_FILL
		
		
		if enter:
			if call_func_enter != "":
				child.call(call_func_enter)
		else:
			if call_func_exit != "":
				child.call(call_func_exit)
