extends TextureRect

func _ready() -> void:
	Index.connect("change_tile",self,"refresh_tile")

func refresh_tile():
	texture = Index.tile.icon
