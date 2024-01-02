extends AnimationButtonClass

export(String) var propriety: String

func _ready() -> void:
	Index.env.set(propriety,pressed)

func _pressed() -> void:
	button_animated()
	Index.env.set(propriety,pressed)
