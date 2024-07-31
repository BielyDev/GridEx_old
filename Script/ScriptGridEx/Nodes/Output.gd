extends GNode

onready var script_text: Label = $Panel/Script

func _ready() -> void:
	is_output = true

func _on_Output_from_value(new_value) -> void:
	script_text.text = str(from_value != null)
	
	run_functions(from_functions)


func run_functions(value):
	if value is Dictionary == false:
		for f in value:
			run_functions(f)
	else:
		if is_instance_valid(value.node):
			value.node.call_deferred(value.function)

