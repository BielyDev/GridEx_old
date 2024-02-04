extends TextureButton

export(Vector3) var axis: Vector3

onready var Par: Camera = $"../../View/Pivot/Camera"

func _pressed() -> void:
	apply_axis(axis)

func apply_axis(_vector: Vector3) -> void:
	Par.Pos.state = Par.Pos.STATE.ORTHOGONAL
	Par.Cam.projection = Camera.PROJECTION_ORTHOGONAL
	Par.Pos.global_transform.origin = Vector3()
	Par.Pos.rotation_degrees.x = _vector.x
	Par.Pos.rotation_degrees.y = _vector.y
	
	Par.Cam.call_deferred("look_at",Par.Pos.global_transform.origin,Vector3.UP)
	
	yield(get_tree().create_timer(0.1),"timeout")
	
	if axis.x != 0:
		var tw = create_tween()
		tw.tween_property(Par.Cam,"rotation_degrees:y",0,0.1)
