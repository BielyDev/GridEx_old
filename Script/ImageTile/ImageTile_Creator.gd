extends Control

onready var Tex: TextureButton = $"%Tex"
onready var panel: VBoxContainer = $Panel
onready var Seletor: TextureRect = $"%Seletor"
onready var Select_3d: MeshInstance = $World/Select_3d
onready var Preview_2d: TextureRect = $Panel/Up/Preview2D
onready var Ray: RayCast = $"View/View_Container/Viewport/3D_View/Camera/Ray"
onready var Cam: Camera = $"View/View_Container/Viewport/3D_View/Camera"
onready var Pos: Spatial = $"View/View_Container/Viewport/3D_View/Pos"
onready var x = $"%x"

export var distance: float = 0.05
var image = Image.new()
var image_tex = ImageTexture.new()
var resolution_selection: Vector2 = Vector2(8,8)

func _ready() -> void:
	Pos.block_view = true
	UI.ready_animated_complex(panel,$Background)


func _process(delta: float) -> void:
	if Tex.pressed:
		var mouse_position = Tex.get_local_mouse_position()
		var scale = calculate_scale() * distance
		
		mouse_position.x = clamp(mouse_position.x,0,Tex.rect_size.x)
		mouse_position.y = clamp(mouse_position.y,0,Tex.rect_size.y)
		
		var pos =  mouse_position - (Seletor.rect_size/2)
		#Seletor.rect_position = pos.snapped(Vector2(57.4,57.4))
		
		Seletor.rect_position = pos.snapped(Vector2(x.value * scale,x.value * scale))
		
	
	var mouse3d = Cam.project_position(get_global_mouse_position(),40)
	Ray.look_at(mouse3d,Vector3.UP)
	
	Select_3d.global_transform.origin = Ray.get_collision_point().snapped(Vector3(2,2,2)) + Vector3(1,0,0)


func _on_OpenImage_pressed() -> void:
	Pos.block_view = true
	IndexLayer.file_explore(
		["*.png","*.jpg","*.jpeg","*.svg"],
		self,
		"confirm_path",
		"cancel",
		FileDialog.MODE_OPEN_FILE
	)

func confirm_path(dir: String,file: String) -> void:
	Pos.block_view = false
	image.load(dir)
	image_tex.create_from_image(image)
	image_tex.resource_path = dir
	
	Tex.texture_normal = image_tex




func _on_filter_toggled(button_pressed: bool) -> void:
	if button_pressed:
		image_tex.flags = image_tex.FLAGS_DEFAULT
	else:
		image_tex.flags = image_tex.FLAG_MIRRORED_REPEAT


func _on_Tex_button_up() -> void:
	
	
	
	if image == null:
		return
	
	var image_selected = Image.new()
	var image_texture_selected = ImageTexture.new()
	
	
	image_selected.create(resolution_selection.x,resolution_selection.y,false,Image.FORMAT_RGBA8)
	
	image.lock()
	image_selected.lock()
	
	var scale = calculate_scale()
	
	
	for pixel_x in range(resolution_selection.x):
		for pixel_y in range(resolution_selection.y):
			image_selected.set_pixel(
				pixel_x,
				pixel_y,
				image.get_pixel(
					int(Seletor.rect_position.x * (scale))+pixel_x,
					int(Seletor.rect_position.y * (scale))+pixel_y)
			)#VOLTAR AQUI
	
	image.unlock()
	image_selected.unlock()
	
	image_texture_selected.create_from_image(image_selected)
	image_texture_selected.flags = image_tex.flags
	Preview_2d.set_deferred("texture", image_texture_selected)
	
	Select_3d.get_active_material(0).albedo_texture = image_texture_selected


func _on_View_Container_mouse_entered() -> void:
	Pos.block_view = false

func _on_View_Container_mouse_exited() -> void:
	Pos.block_view = true


func _on_x_value_changed(value):
	x.max_value = image.get_width()
	
	resolution_selection = Vector2(value,value)
	
	var scale = calculate_scale()
	
	Seletor.rect_size = (resolution_selection * scale)
	#print(image.get_size() - Tex.rect_size)


func calculate_scale() -> float:
	var scales = Vector2(
		image.get_size().x / image.get_width(),
		image.get_size().y / image.get_height()
	)
	var scale = min(scales.x,scales.y)
	
	return scale

