extends MeshInstance

func _ready() -> void:
	Index.connect("model_tile_selection",self,"refresh_model")

func refresh_model(mesh_preview: MeshInstance):
	mesh = mesh_preview.mesh
	scale = mesh_preview.scale
