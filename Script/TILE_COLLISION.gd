extends CheckBox


func _pressed() -> void:
	Index.ray.set_collision_mask_bit(1,pressed)
