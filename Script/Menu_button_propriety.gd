extends MenuButton

export(Array,Script) var Scripts: Array = []


func _ready() -> void:
	get_popup().connect("id_pressed",self,"press")

func press(id: int) -> void:
	var node = Node.new()
	add_child(node)
	
	node.set_script(Scripts[id])
	node.start()
	
	yield(node,"finished")
	node.queue_free()

