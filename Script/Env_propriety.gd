extends AnimationButtonClass

export(String) var propriety: String
export(String) var my_propriety: String = "pressed"
export(String) var my_signal: String = "pressed"
export(NodePath) var Preferences_path: NodePath = "../../../../../../../../.."

onready var Save_node: Node = $"%Save"
onready var Preferences: Control = get_node(Preferences_path)

func _ready() -> void:
	set(my_propriety,Index.env.get(propriety))
	Preferences.settings.settings[propriety] = get(my_propriety)
	
	connect(my_signal,self,"action")

func action(value:int = 0) -> void:
	Index.env.set(propriety,get(my_propriety))
	Preferences.settings.settings[propriety] = get(my_propriety)
