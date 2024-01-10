extends HBoxContainer

onready var Pro: PanelContainer = $"../.."

var prop_new = preload("res://Scene/Import/Propriety.tscn")

export(String) var propriety: String

func start() -> void:
	var prop = prop_new.instance()
	prop.types = [{name = propriety,type = prop.TYPE.VECTOR}]
	prop.mat = Pro.tile
	
	add_child(prop)

func clear() -> void:
	if get_child_count() >= 2:
		get_child(1).queue_free()
