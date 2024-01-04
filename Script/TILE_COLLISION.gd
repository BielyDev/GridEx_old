extends AnimationButtonClass


func _pressed() -> void:
	Index.ray.collide_with_bodies = pressed
