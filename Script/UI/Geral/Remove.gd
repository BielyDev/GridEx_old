extends MenuButton

onready var Tiles: VBoxContainer = $"%Tile Groups"

func _ready() -> void:
	get_popup().connect("id_pressed",self,"press")

func _pressed() -> void:
	get_popup().clear()
	
	for childs in Tiles.get_children():
		get_popup().add_item(childs.name)

func press(id: int) -> void:
	Tiles.get_child(id).queue_free()
