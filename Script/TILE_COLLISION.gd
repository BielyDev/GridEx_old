extends AnimationButtonClass


func _pressed() -> void:
	Index.view3d.ray.collide_with_bodies = pressed
