extends Spatial

onready var Select_3d: MeshInstance = $Select_3d
onready var Pos: Spatial = $"../View/View_Container/Viewport/3D_View/Pos"
onready var Model: MeshInstance = $Model

var mesh: Mesh = Mesh.new()
var surface: SurfaceTool = SurfaceTool.new()

var all_vertex = []

	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click_left") and Pos.block_view == false:
		
		surface.begin(Mesh.PRIMITIVE_POINTS)
		
	if Input.is_action_just_pressed("click_left") and Pos.block_view == false:
		
		surface.begin(Mesh.PRIMITIVE_TRIANGLE_STRIP)
		
		var is_add = true
		
		for vertex in Select_3d.mesh.surface_get_arrays(0)[0]:
			
			surface.add_vertex(-Select_3d.to_local(vertex)-Vector3(2,0,0))
			
			for avertex in all_vertex:
				
				if avertex == -Select_3d.to_local(vertex)-Vector3(2,0,0):
					is_add = false
			
			if is_add:
				all_vertex.push_back(-Select_3d.to_local(vertex)-Vector3(2,0,0))
		
		
		mesh = surface.commit(mesh)
		
		Model.mesh = mesh


func organize(a: Vector3,b: Vector3) -> int:
	var length_a = a.length()
	var length_b = b.length()
	
	if length_a < length_b:
		return -1
	elif length_a > length_b:
		return 1
	else:
		return 0
	


