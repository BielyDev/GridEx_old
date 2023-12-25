extends Button

export(Index.SETT) var propriety: int

func _ready() -> void:
	Index.settings[propriety] = pressed

func _pressed() -> void:
	Index.settings[propriety] = pressed
