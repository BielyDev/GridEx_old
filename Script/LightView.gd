extends PanelContainer

onready var Pos: Position3D = $View/View/Pos
onready var LightControl: Control = $"../../../../../.."

var mouse_enabled: bool = false


func _ready() -> void:
	Pos.global_transform.origin = LightControl.LightConfig.global_transform.origin


func _on_PanelView_mouse_entered() -> void:
	mouse_enabled = true

func _on_PanelView_mouse_exited() -> void:
	mouse_enabled = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if (Input.is_mouse_button_pressed(BUTTON_LEFT) or Input.is_mouse_button_pressed(BUTTON_RIGHT)) and mouse_enabled:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			Pos.rotation.y += event.relative.x * 0.005
			Pos.rotation.x += event.relative.y * 0.005
			Pos.rotation_degrees.x = clamp(Pos.rotation_degrees.x,-45,90)
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
