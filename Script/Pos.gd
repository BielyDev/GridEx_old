extends Spatial

class_name Camera_Controller

enum STATE {IDLE,TRANSLATION_POS,ROTATION_CAM,FIRST_PERSON,BLOCK,ORTHOGONAL}

var sensi: float = 0.02
var speed_vel: float = 0.05
var block_view: bool = false

var state: int = 0
var velocity: Vector3
var lock_pos_cam: Vector3

export(bool) var Index_values: bool = false

export(NodePath) var PosLock_path: NodePath
export(NodePath) var CamLock_path: NodePath
export(NodePath) var Cam_path: NodePath
export(NodePath) var Ray_path: NodePath

onready var PosLock: Spatial = get_node(PosLock_path)
onready var CamLock: Spatial = get_node(CamLock_path)
onready var Cam: Camera = get_node(Cam_path)
onready var Ray: RayCast = get_node_or_null(Ray_path)



func _ready() -> void:
	_reset_pos_cam()
	
	if Index_values:
		Index.view3d.cam = Cam
		Index.view3d.ray = Ray
		Index.view3d.pos = self


func _input(_event: InputEvent) -> void:
	if state == STATE.BLOCK or block_view:
		return
	
	if state == STATE.ORTHOGONAL:
		Cam.projection = Camera.PROJECTION_ORTHOGONAL
	
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

func _process(_delta: float) -> void:
	if Cam.projection == Camera.PROJECTION_ORTHOGONAL:
		Cam.size = Cam.global_transform.origin.distance_to(Vector3())
		
	
	if Index_values:
		block_view = Index.block_view
	
	if block_view:
		return
	
	if state == STATE.FIRST_PERSON:
		_translate_cam()
	if state == STATE.ROTATION_CAM:
		Cam.look_at(global_transform.origin,Vector3.UP)
	
	adjustment_rotation_translation()
	
	velocity =  velocity.linear_interpolate(Vector3(),0.1)
	
	CamLock.global_translate(velocity * speed_vel)
	get_parent().emit_signal("camera_transform",Cam.global_transform,Cam.global_rotation)


func reset_transform() -> void:
	speed_vel = (
		(Index.settings[Index.SETT.CAM_SENSI_MOVE] * 0.0003) * 
		(int(Input.is_action_pressed("speed")) + 1)
	)
	
	if Input.is_action_pressed("reset_cam"):
		rotation_degrees = Vector3(45,-180,0)
		global_transform.origin = Vector3()
		CamLock.transform.origin = Vector3(0,0,-10)
		Cam.rotation_degrees = Vector3(-45,0,0)
		_reset_pos_cam(false)


func _zoom_moviment() -> void:
	if Input.is_action_pressed("middle_up"):
		if CamLock.global_transform.origin.distance_to(global_transform.origin) >= 1:
			CamLock.transform.origin.z += int(Input.is_action_pressed("speed")) + 1.5
	if Input.is_action_pressed("middle_down"):
		if CamLock.global_transform.origin.distance_to(global_transform.origin) <= 100:
			CamLock.transform.origin.z += -(int(Input.is_action_pressed("speed")) + 1.5)


func _reset_pos_cam(self_poslock: bool = true) -> void:
	lock_pos_cam = CamLock.global_transform.origin
	var guar_rot_cam = CamLock.global_rotation
	
	if self_poslock:
		global_transform.origin = PosLock.global_transform.origin
	
	CamLock.global_transform.origin = lock_pos_cam
	CamLock.global_rotation = guar_rot_cam
	
	look_at(CamLock.global_transform.origin,Vector3.DOWN)
	
	CamLock.global_transform.origin = lock_pos_cam
	CamLock.global_rotation = guar_rot_cam
	
	state = STATE.IDLE


func _rotation_local(mouse_relative: Vector2) -> void:
	var mouse_pos = (Vector3(-mouse_relative.y,mouse_relative.x ,0)) * (Index.settings[Index.SETT.CAM_SENSI_MOVE] * 0.013)
	var rot = rotation_degrees + -mouse_pos
	
	rotation_degrees.y = rot.linear_interpolate(rot,0.1).y
	rotation_degrees.x = rot.linear_interpolate(rot,0.1).x
	
	rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
	
	Cam.projection = Camera.PROJECTION_PERSPECTIVE


func _rotation_cam(mouse_relative: Vector2) -> void:
	var ratue: int = 25
	
	if Cam.projection == Camera.PROJECTION_PERSPECTIVE:
		Cam.rotation_degrees.y += -mouse_relative.x * (Index.settings[Index.SETT.CAM_SENSI] * 0.004)
		Cam.rotation_degrees.x += -mouse_relative.y * (Index.settings[Index.SETT.CAM_SENSI] * 0.005)
	
	if mouse_relative.x <= -ratue or mouse_relative.x >= ratue or mouse_relative.y <= -ratue or mouse_relative.y >= ratue:
		Cam.projection = Camera.PROJECTION_PERSPECTIVE
	
	Cam.rotation_degrees.x = clamp(Cam.rotation_degrees.x, -90, 90)


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
	
	if Cam.projection == Camera.PROJECTION_PERSPECTIVE:
		translate_object_local(Vector3(-mouse_relative.x,-mouse_relative.y,0)*sensi)
	else:
		translate_object_local(Vector3(-mouse_relative.x,-mouse_relative.y,0)*sensi)


var adjustment: bool = false
func adjustment_rotation_translation() -> void:
	if state == STATE.TRANSLATION_POS:
		adjustment = true
	else:
		if adjustment == true:
			rotation_degrees.z = 180
			adjustment = false

