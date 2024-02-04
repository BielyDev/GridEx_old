extends Slider

export(String) var propriety: String

onready var Save_node: Node = $"%Save"
onready var Preferences: Control = $"../../../../../../../../.."

func _ready() -> void:
	value = Index.env.get(propriety)
	Preferences.settings.settings[propriety] = value
	connect("value_changed",self,"_change_value")

func _change_value(value: float) -> void:
	Index.env.set(propriety,value)
	Preferences.settings.settings[propriety] = value
