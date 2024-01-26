extends Button

onready var Par: Control = $"../../../.."
onready var PanelNode: PanelContainer = $"../../.."
onready var Background: PanelContainer = $"../../../../Background"

func _pressed() -> void:
	Index.block_view = true
	
	IndexLayer.file_explore(
		["*.gridex"],
		self,
		"ok",
		"cancel"
	)

func ok(dir: String, file:String):
	Index.open_project(dir)
	Index.block_view = true
	UI.queue_animated_complex(Par,PanelNode,Background)

func cancel():
	pass
