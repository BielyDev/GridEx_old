extends VBoxContainer

enum TYPE {BOOL,NUM,VECTOR,COLOR,TEXTURE}

onready var List := $Vbox/list
onready var Hide_show: Button = $hide_show

var script_animation: Script = preload("res://Script/Import_Config/set_propriety.gd")
var TextureLoadButton_new: PackedScene = preload("res://Scene/Import/TextureLoadButton.tscn")

var mat: SpatialMaterial

var types: Array = []
var tittle: String
#{name = "albedo_color",type = TYPE.COLOR},{name = "albedo_texture",type = TYPE.TEXTURE}

func _ready() -> void:
	Hide_show.text = tittle
	Hide_show.hide_animated()
	
	create_types()


func create_types() -> void:
	for i in types:
		match i.type:
			TYPE.BOOL:
				var check: CheckBox = CheckBox.new()
				var hbox = add(i.name)
				config(check,"on",i.name,"pressed")
				
				hbox.add_child(check)
			TYPE.NUM:
				var num: HSlider = HSlider.new()
				var hbox = add(i.name)
				config(num,"",i.name,"value")
				
				hbox.add_child(num)
			TYPE.COLOR:
				var color: ColorPickerButton = ColorPickerButton.new()
				var hbox = add(i.name)
				config(color,"",i.name,"color")
				
				hbox.add_child(color)
			TYPE.TEXTURE:
				var Tex = TextureLoadButton_new.instance()
				var hbox = add(i.name)
				Tex.mat = mat
				
				hbox.add_child(Tex)



func add(text: String):
	var list: HBoxContainer = HBoxContainer.new()
	list.size_flags_horizontal = SIZE_EXPAND_FILL
	List.add_child(list)
	
	var tittle: Label = Label.new()
	tittle.text = text
	
	list.add_child(tittle)
	return list


func config(item: Control,text: String,mat_propriety: String,propriety: String) -> void:
	item.size_flags_horizontal = 10
	item.rect_min_size.x = 100
	item.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	if text != "":
		item.text = text
	
	item.set_script(script_animation)
	item.mat = mat
	item.mat_propriety = mat_propriety
	item.propriety = propriety

