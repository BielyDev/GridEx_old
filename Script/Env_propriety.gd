extends AnimationButtonClass

export(String) var propriety: String

onready var Save_node: Node = $"%Save"
onready var Preferences: Control = $"../../../../../../../../.."

func _ready() -> void:
	pressed = Index.env.get(propriety)
	Preferences.settings.settings[propriety] = pressed

func _pressed() -> void:
	Index.env.set(propriety,pressed)
	Preferences.settings.settings[propriety] = pressed
