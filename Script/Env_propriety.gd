extends AnimationButtonClass

export(String) var propriety: String

func _ready() -> void:
	pressed = Index.env.get(propriety)

func _pressed() -> void:
	Index.env.set(propriety,pressed)
