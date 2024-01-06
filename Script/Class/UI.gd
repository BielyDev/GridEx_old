extends GridEx

class_name UI

static func ready_animated(object: Control) -> bool:
	var TwUI = add_tween()
	center_pivot(object)
	
	TwUI.animated_tween_ui(object,"rect_scale",Vector2(),object.rect_scale,0.6,Tween.TRANS_CUBIC)
	yield(TwUI,"tween_all_completed")
	TwUI.queue_free()
	
	return true


static func ready_animated_complex(object_size: Control,object_opacity: Control) -> bool:
	var TwUI = add_tween()
	center_pivot(object_size)
	
	TwUI.animated_tween_ui(object_size,"rect_scale",Vector2(),object_size.rect_scale,0.6,Tween.TRANS_CUBIC)
	TwUI.animated_tween_ui(object_opacity,"modulate",Color(1,1,1,0),object_opacity.modulate,0.6,Tween.TRANS_CUBIC)
	
	yield(TwUI,"tween_all_completed")
	
	TwUI.queue_free()
	
	return true



static func queue_animated(object: Control) -> bool:
	var TwUI = add_tween()
	center_pivot(object)
	
	TwUI.animated_tween_ui(object,"rect_scale",object.rect_scale,Vector2(),0.6,Tween.TRANS_CUBIC)
	
	yield(TwUI,"tween_all_completed")
	
	object.queue_free()
	TwUI.queue_free()
	
	return true


static func queue_animated_complex(object: Control,object_size: Control,object_opacity: Control) -> bool:
	var TwUI = add_tween()
	center_pivot(object_size)
	
	TwUI.animated_tween_ui(object_size,"rect_scale",object_size.rect_scale,Vector2(),0.6,Tween.TRANS_CUBIC)
	TwUI.animated_tween_ui(object_opacity,"modulate",object_opacity.modulate,Color(1,1,1,0))
	
	yield(TwUI,"tween_all_completed")
	
	object.queue_free()
	TwUI.queue_free()
	
	return true



static func add_tween() -> TweenUI:
	var TwUI: TweenUI = TweenUI.new()
	Index.add_child(TwUI)
	
	return TwUI


static func center_pivot(object: Control) -> void:
	object.rect_pivot_offset = object.rect_size/2

