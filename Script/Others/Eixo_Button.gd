extends TextureButton

export(Vector3) var axis: Vector3

func _pressed() -> void:
	apply_axis(axis)

func apply_axis(_vector: Vector3) -> void:
	Index.view3d.pos.state = Index.view3d.pos.STATE.ORTHOGONAL
	Index.view3d.cam.projection = Camera.PROJECTION_ORTHOGONAL
	Index.view3d.pos.global_transform.origin = Vector3()
	Index.view3d.pos.rotation_degrees.x = _vector.x
	
	Index.view3d.cam.call_deferred("look_at",Index.view3d.pos.global_transform.origin,Vector3.UP)
	
	yield(get_tree().create_timer(0.1),"timeout")
	
	if axis.x != 0:
		var tw = create_tween()
		tw.tween_property(Index.view3d.cam,"rotation_degrees:y",0,0.1)
