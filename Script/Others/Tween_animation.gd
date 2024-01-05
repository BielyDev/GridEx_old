extends Tween

class_name TweenUI

var delete: bool = false

func _ready() -> void:
	if delete:
		connect("tween_all_completed",self,"queue")

func animated_tween_ui(object: Node,propriety: String, value_initial,value_final,time: float = 0.5,transition: int = Tween.TRANS_BACK) -> void:
	interpolate_property(object,propriety,value_initial,value_final,time,transition)
	start()

func queue() -> void:
	queue_free()
