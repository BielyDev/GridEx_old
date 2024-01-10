extends VBoxContainer

onready var Tittle: Label = $Tittle
onready var Stream_texture: PanelContainer = $StreamTexture

var animated_texture: AnimatedTexture
var frame: int
var img


func _ready() -> void:
	Tittle.text = str("Frame ",frame)
	Stream_texture.tex_ready = img
	
	animated_texture.set_frame_texture(frame,img)

func _on_StreamTexture_texture_chaged(texture) -> void:
	img = texture
	animated_texture.set_frame_texture(frame,img)

func _on_Sec_value_changed(value: float) -> void:
	animated_texture.set_frame_delay(frame,value)
