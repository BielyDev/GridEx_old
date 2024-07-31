extends HBoxContainer

onready var preferences: Control = $"../../../../../../../.."

var resolutions = [
	Vector2(1024,576),
	Vector2(1280,720),
	Vector2(1920,1080),
	Vector2(2560,1440),
]

func _on_Resolutions_options_item_selected(index: int) -> void:
	#print(Index.edit_node.View.size)
	get_viewport().size = resolutions[index]
	
	preferences.settings.settings["resolution"] = index

