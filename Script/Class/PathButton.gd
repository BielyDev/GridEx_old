extends AnimationButtonClass

class_name ButtonPath

export(NodePath) var FileDialogPath: NodePath

onready var file_dialog: FileDialog = get_node(FileDialogPath)

var path: String

func _ready() -> void:
	var path_ = path.get_base_dir()
	var array_path_name = path_.split("/")
	
	text = array_path_name[array_path_name.size()-1]

func _pressed() -> void:
	file_dialog.current_path = path

