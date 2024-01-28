extends Camera

onready var x: Position2D = $"../../../X"
onready var y: Position2D = $"../../../Y"
onready var z: Position2D = $"../../../Z"
onready var x_2: Position2D = $"../../../X2"
onready var y_2: Position2D = $"../../../Y2"
onready var z_2: Position2D = $"../../../Z2"

onready var eixo_z: Position3D = $"../../Model/Eixo_z/Pos"
onready var eixo_x: Position3D = $"../../Model/Eixo_x/Pos"
onready var eixo_y: Position3D = $"../../Model/Eixo_y/Pos"
onready var eixo_y_2: Position3D = $"../../Model/Eixo_y/Pos2"
onready var eixo_z_2: Position3D = $"../../Model/Eixo_z/Pos2"
onready var eixo_x_2: Position3D = $"../../Model/Eixo_x/Pos2"


func _ready() -> void:
	Index.view2d.axis = $"../../../.."
	Index.view2d.viewport = $"../../../../../View/Viewport"


func _process(_delta: float) -> void:
	get_parent().global_rotation = Index.view3d.cam.global_rotation
	
	var z_pos = unproject_position(eixo_z.global_transform.origin)
	z.position = z_pos
	
	var x_pos = unproject_position(eixo_x.global_transform.origin)
	x.position = x_pos
	
	var y_pos = unproject_position(eixo_y.global_transform.origin)
	y.position = y_pos
	
	var z_pos_2 = unproject_position(eixo_z_2.global_transform.origin)
	z_2.position = z_pos_2
	
	var x_pos_2 = unproject_position(eixo_x_2.global_transform.origin)
	x_2.position = x_pos_2
	
	var y_pos_2 = unproject_position(eixo_y_2.global_transform.origin)
	y_2.position = y_pos_2
	
	
	if lock_cam:
		Index.view3d.pos.state = Index.view3d.pos.STATE.BLOCK
		Index.view3d.cam.look_at(Index.view3d.pos.global_transform.origin,Vector3.UP)
		
		if Input.is_action_just_released("click_left"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			lock_cam = false
			Index.view3d.pos.state = Index.view3d.pos.STATE.IDLE
			Index.block_view = false

var lock_cam: bool = false

func _on_Rot_gui_input(_event: InputEvent) -> void:
	if _event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and Index.block_view:
			
			Index.view3d.pos._rotation_local(_event.relative)
			Index.block_view = true
			
			lock_cam = true
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
