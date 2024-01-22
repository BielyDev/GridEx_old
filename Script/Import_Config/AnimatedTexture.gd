extends PanelContainer

signal texture_chaged(texture)

onready var Frames: VBoxContainer = $Vbox/Scroll/Frames

var frame_new: PackedScene = preload("res://Script/Import_Config/Frame.tscn")
var animated: AnimatedTexture = AnimatedTexture.new()

var tex_ready


func _ready() -> void:
	if tex_ready != null:
		animated = tex_ready
		
		for frames in range(animated.frames-1):
			var frame = frame_new.instance()
			frame.frame = frames
			frame.animated_texture = animated
			frame.img = animated.get_frame_texture(frames)
			
			Frames.add_child(frame)


func _on_Add_pressed() -> void:
	animated.frames += 1
	var frame = frame_new.instance()
	frame.frame = Frames.get_child_count()
	frame.animated_texture = animated
	
	Frames.add_child(frame)
	emit_signal("texture_chaged",animated)


func _on_Remove_pressed() -> void:
	animated.frames += -1
	Frames.get_child(Frames.get_child_count()-1).queue_free()


func _on_Play_pressed() -> void:
	animated.pause = false
func _on_Stop_pressed() -> void:
	animated.pause = true
