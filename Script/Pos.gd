extends Spatial

class_name Camera_Controller

enum STATE {IDLE,TRANSLATION_POS,ROTATION_CAM,FIRST_PERSON,BLOCK}

var sensi: float = 0.02
var speed_vel: float = 0.05
var block_view: bool = false

var state: int = 0
var velocity: Vector3
var lock_pos_cam: Vector3

export(bool) var Index_values: bool = false

export(NodePath) var PosLock_path: NodePath
export(NodePath) var Cam_path: NodePath
export(NodePath) var Ray_path: NodePath

onready var PosLock: Spatial = get_node(PosLock_path)
onready var Cam: Camera = get_node(Cam_path)
onready var Ray: RayCast = get_node_or_null(Ray_path)


func _ready() -> void:
	_reset_pos_cam()
	
	if Index_values:
		Index.cam = Cam
		Index.ray = Ray


func _input(_event: InputEvent) -> void:
	if state == STATE.BLOCK or block_view:
		return
	
	
	if _event is InputEventMouseButton:
		if state != STATE.FIRST_PERSON:
			_zoom_moviment()
			return
	
	if _event is InputEventMouseMotion:
		if Input.is_mouse_button_pressed(BUTTON_MIDDLE) and Input.is_key_pressed(KEY_SHIFT) and state != STATE.FIRST_PERSON:
			_moviment_mouse_local(_event.relative)
			
			state = STATE.TRANSLATION_POS
			return
		
		if Input.is_mouse_button_pressed(BUTTON_RIGHT):
			
			_rotation_cam(_event.relative)
			
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
			state = STATE.FIRST_PERSON
			
			return
		else:
			if state == STATE.FIRST_PERSON:
				_reset_pos_cam()
			
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		if Input.is_mouse_button_pressed(BUTTON_MIDDLE) and state != STATE.FIRST_PERSON:
			_rotation_local(_event.relative)
			
			state = STATE.ROTATION_CAM
			return

func _unhandled_key_input(event: InputEventKey) -> void:
	reset_transform()

func _physics_process(_delta: float) -> void:
	if Index_values:
		block_view = Index.block_view
	
	if block_view:
		return
	
	if state == STATE.FIRST_PERSON:
		_translate_cam()
	
	velocity =  velocity.linear_interpolate(Vector3(),0.1)
	
	Cam.global_translate(velocity * speed_vel)


func reset_transform() -> void:
	speed_vel = (
		(Index.settings[Index.SETT.CAM_SENSI_MOVE] * 0.0003) * 
		(int(Input.is_action_pressed("speed")) + 1)
	)
	
	if Input.is_action_pressed("reset_cam"):
		rotation_degrees = Vector3(45,-180,0)
		global_transform.origin = Vector3()
		Cam.transform.origin = Vector3(0,0,-10)
		Cam.rotation_degrees = Vector3(0,-180,0)
		_reset_pos_cam()


func _zoom_moviment() -> void:
	if Input.is_action_pressed("middle_up"):
		if Cam.global_transform.origin.distance_to(global_transform.origin) >= 1:
			Cam.transform.origin.z += int(Input.is_action_pressed("speed")) + 1.5
	if Input.is_action_pressed("middle_down"):
		if Cam.global_transform.origin.distance_to(global_transform.origin) <= 100:
			Cam.transform.origin.z += -(int(Input.is_action_pressed("speed")) + 1.5)


func _reset_pos_cam() -> void:
	lock_pos_cam = Cam.global_transform.origin
	var guar_rot_cam = Cam.global_rotation
	
	global_transform.origin = PosLock.global_transform.origin
	
	Cam.global_transform.origin = lock_pos_cam
	Cam.global_rotation = guar_rot_cam
	
	look_at(Cam.global_transform.origin,Vector3.DOWN)
	
	Cam.global_transform.origin = lock_pos_cam
	Cam.global_rotation = guar_rot_cam
	
	state = STATE.IDLE


func _rotation_local(mouse_relative: Vector2) -> void:
	var mouse_pos = (Vector3(-mouse_relative.y,mouse_relative.x ,0)) * (Index.settings[Index.SETT.CAM_SENSI_MOVE] * 0.013)
	var rot = rotation_degrees + -mouse_pos
	
	rotation_degrees.y = rot.linear_interpolate(rot,0.1).y
	rotation_degrees.x = rot.linear_interpolate(rot,0.1).x
	
	rotation_degrees.x = clamp(rotation_degrees.x, -87, 87)


func _rotation_cam(mouse_relative: Vector2) -> void:
	Cam.global_rotation.y += -mouse_relative.x * (Index.settings[Index.SETT.CAM_SENSI] * 0.0001)
	Cam.global_rotation.x += -mouse_relative.y * (Index.settings[Index.SETT.CAM_SENSI] * 0.0001)
	
	Cam.global_rotation.x = clamp(Cam.global_rotation.x, -87, 87)


func _translate_cam() -> void:
	var direction: Vector3 = Vector3(
		Input.get_axis("left","right"),
		Input.get_axis("up","down"),
		Input.get_axis("up_cam","down_cam")
	)
	
	velocity.x += direction.y * Cam.global_transform.basis.z.x
	velocity.y += direction.y * Cam.global_transform.basis.z.y
	velocity.z += direction.y * Cam.global_transform.basis.z.z
	
	velocity.x += direction.x * Cam.global_transform.basis.x.x
	velocity.y += direction.x * Cam.global_transform.basis.x.y
	velocity.z += direction.x * Cam.global_transform.basis.x.z
	
	velocity.x += direction.z * Cam.global_transform.basis.y.x
	velocity.y += direction.z * Cam.global_transform.basis.y.y
	velocity.z += direction.z * Cam.global_transform.basis.y.z


func _moviment_mouse_local(mouse_relative: Vector2) -> void:
	var mouse_pos = Vector3(
		(
			mouse_relative.x  * Cam.global_transform.basis.z.normalized().z
		) * sensi,
		
		-mouse_relative.y * sensi,
		
		(
			-mouse_relative.x * Cam.global_transform.basis.z.normalized().x
		) * sensi
	)
	
	transform.origin += -mouse_pos

