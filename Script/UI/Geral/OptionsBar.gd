extends PanelContainer

onready var Option: OptionButton = $"%Option"
onready var Mirror: OptionButton = $"%Mirror"
onready var Rand: OptionButton = $"%Rand"
onready var Rotation: OptionButton = $"%Rotation"

func _ready() -> void:
	yield(get_tree().create_timer(0.5),"timeout")
	
	Index.edit_node.World3D.Add.Rand = Rand
	Index.block.Option = Option
	Index.edit_node.World3D.Add.Mirror = Mirror
	Index.edit_node.World3D.Add.Rotation = Rotation


func _on_Mirror_item_selected(index: int) -> void:
	Rotation.disabled = index != 3

func _on_RotSnapped_toggled(button_pressed: bool) -> void:
	Index.snapped.rot = button_pressed
