extends GNode

onready var texture_load_button: PanelContainer = $Panel/Texture/TextureLoadButton

var texture setget _texture

func _ready() -> void:
	texture_load_button.mat = self
	texture_load_button.mat_propriety = "texture"

func _texture(tex) -> void:
	texture = tex
	self.value = texture
	
	yield(get_tree().create_timer(0.5),"timeout")
	emit_signal("change_value",texture)



func _on_TextureLoadButton_change_texture(_texture) -> void:
	self.texture = _texture
	print("as")
