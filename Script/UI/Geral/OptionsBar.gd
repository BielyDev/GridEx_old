extends PanelContainer

onready var Option: OptionButton = $"%Option"
onready var Mirror: OptionButton = $"%Mirror"
onready var Rand: OptionButton = $"%Rand"

func _ready() -> void:
	yield(get_tree().create_timer(0.5),"timeout")
	
	Index.edit_node.World3D.Add.Rand = Rand
	Index.block.Option = Option
	Index.edit_node.World3D.Add.Mirror = Mirror
