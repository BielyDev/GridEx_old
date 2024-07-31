extends GNode

var vector

func _on_Texture_to_vector3_from_value(new_value) -> void:
	var get_image = from_value[0].node.texture
	
	vector = []
	if get_image == null:
		self.value = vector
		return
	
	var image = get_image.get_data().duplicate()
	
	if image != null:
		
		image.lock()
		
		for x in image.get_size().x:
			for y in image.get_size().y:
				var pixel = image.get_pixel(x,y)
				var up:float = (pixel.r + pixel.g + pixel.b) * 4
				vector.append(Vector3(x,up,y))
		
		image.unlock()
	
	self.value = vector
