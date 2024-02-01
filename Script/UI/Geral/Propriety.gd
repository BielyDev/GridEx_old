extends VBoxContainer

enum TYPE {BOOL,NUM,OPTION,VECTOR,COLOR,TEXTURE}

onready var List := $Vbox/list
onready var Hide_show: Button = $hide_show

var TextureLoadButton_new: PackedScene = preload("res://Scene/Import/TextureLoadButton.tscn")
var BoolButton_new: PackedScene = preload("res://Scene/Import/Types/Bool.tscn")
var NumButton_new: PackedScene = preload("res://Scene/Import/Types/Num.tscn")
var VecButton_new: PackedScene = preload("res://Scene/Resource/Vector.tscn")
var OptionButton_new: PackedScene = preload("res://Scene/Import/Types/Option.tscn")
var ColorButton_new: PackedScene = preload("res://Scene/Import/Types/Color.tscn")

var mat

var types: Array = []
var tittle: String
#{name = "albedo_color",type = TYPE.COLOR,others = []}

func _ready() -> void:
	Hide_show.text = tittle
	Hide_show.hide_animated()
	
	create_types()


func create_types() -> void:
	for i in types:
		match i.type:
			TYPE.BOOL:
				var Bool = BoolButton_new.instance()
				var hbox = add(i.name)
				Bool.mat = mat
				Bool.mat_propriety = i.name
				
				hbox.add_child(Bool)
			TYPE.NUM:
				var Num = NumButton_new.instance()
				var hbox = add(i.name)
				Num.mat = mat
				Num.mat_propriety = i.name
				Num.min_value = i.values[0]
				Num.max_value = i.values[1]
				
				hbox.add_child(Num)
			TYPE.VECTOR:
				var Vec = VecButton_new.instance()
				var hbox = add(i.name)
				Vec.node = mat
				Vec.propriety = i.name
				
				hbox.add_child(Vec)
			TYPE.OPTION:
				var Option = OptionButton_new.instance()
				var hbox = add(i.name)
				Option.mat = mat
				Option.mat_propriety = i.name
				for itens in i.options:
					Option.add_item(itens)
				
				hbox.add_child(Option)
			TYPE.COLOR:
				var _Color = ColorButton_new.instance()
				var hbox = add(i.name)
				_Color.mat = mat
				_Color.mat_propriety = i.name
				
				hbox.add_child(_Color)
			TYPE.TEXTURE:
				var Tex = TextureLoadButton_new.instance()
				var hbox = add(i.name)
				Tex.mat = mat
				Tex.mat_propriety = i.name
				
				hbox.add_child(Tex)


func add(text: String):
	var list: HBoxContainer = HBoxContainer.new()
	list.size_flags_horizontal = SIZE_EXPAND_FILL
	List.add_child(list)
	
	var _tittle: Label = Label.new()
	_tittle.text = text
	
	list.add_child(_tittle)
	return list

