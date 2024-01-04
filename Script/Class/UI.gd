extends Node

class_name UI

static func ready_animated(object: Control) -> bool:
	object.rect_pivot_offset = object.rect_size/2
	Index.animated_tween_ui(object,"rect_scale",Vector2(),object.rect_scale,0.6,Tween.TRANS_CUBIC)
	
	return true

static func ready_animated_complex(object_size: Control,object_opacity: Control) -> bool:
	object_size.rect_pivot_offset = object_size.rect_size/2
	Index.animated_tween_ui(object_size,"rect_scale",Vector2(),object_size.rect_scale,0.6,Tween.TRANS_CUBIC)
	
	Index.animated_tween_ui(object_opacity,"modulate",Color(1,1,1,0),object_opacity.modulate,0.6,Tween.TRANS_CUBIC)
	
	return true


static func queue_animated(object: Control) -> bool:
	object.rect_pivot_offset = object.rect_size/2
	Index.animated_tween_ui(object,"rect_scale",object.rect_scale,Vector2(),0.6,Tween.TRANS_CUBIC)
	
	yield(Index.Tw,"tween_completed")
	
	object.queue_free()
	
	return true

static func queue_animated_complex(object: Control,object_size: Control,object_opacity: Control) -> bool:
	object_size.rect_pivot_offset = object_size.rect_size/2
	Index.animated_tween_ui(object_size,"rect_scale",object_size.rect_scale,Vector2(),0.6,Tween.TRANS_CUBIC)
	
	Index.animated_tween_ui(object_opacity,"modulate",object_opacity.modulate,Color(1,1,1,0))
	
	yield(Index.Tw,"tween_completed")
	
	object.queue_free()
	
	return true

