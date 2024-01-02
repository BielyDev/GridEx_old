extends AnimationButtonClass


func _pressed() -> void:
	button_animated()
	Index.ray.collide_with_bodies = pressed
