extends Control

onready var Tex: TextureButton = $"%Tex"
onready var panel: VBoxContainer = $Panel
onready var Seletor: TextureRect = $"%Seletor"
onready var Select_3d: MeshInstance = $World/Select_3d
onready var Preview_2d: TextureRect = $Panel/Up/Preview2D
onready var Ray: RayCast = $"View/View_Container/Viewport/3D_View/Camera/Ray"
onready var Cam: Camera = $"View/View_Container/Viewport/3D_View/Camera"
onready var Pos: Spatial = $"View/View_Container/Viewport/3D_View/Pos"


var image = Image.new()
var image_tex = ImageTexture.new()


func _ready() -> void:
	Pos.block_view = true
	UI.ready_animated_complex(panel,$Background)


func _process(delta: float) -> void:
	if Tex.pressed:
		var pos =  Tex.get_local_mouse_position() - (Seletor.rect_size/2)
		Seletor.rect_position = pos.snapped(Vector2(57.4,57.4))
	
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
	
	
	image_selected.create(8,8,false,Image.FORMAT_RGBA8)
	
	image.lock()
	image_selected.lock()
	
	
	for pixel_x in range(8):
		for pixel_y in range(8):
			image_selected.set_pixel(
				pixel_x,
				pixel_y,
				image.get_pixel(
					int(Seletor.rect_position.x * 0.14)+pixel_x,
					int(Seletor.rect_position.y * 0.14)+pixel_y)
			)
	
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
