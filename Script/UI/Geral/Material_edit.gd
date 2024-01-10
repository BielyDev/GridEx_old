extends Control

onready var Vbox: VBoxContainer = $Vbox/Vbox/Scroll/Vbox
onready var Tittle_node: Label = $Vbox/Hbox/Tittle

var propriety_new: PackedScene = preload("res://Scene/Import/Propriety.tscn")

var mat: SpatialMaterial
var tittle: String

func _ready() -> void:
	UI.ready_animated(self)
	
	Tittle_node.text = tittle
	
	create_propriety()

func create_propriety() -> void:
	var pro = propriety_new.instance()
	
	propriety("Flags",[
		{name = "flags_transparent",type = pro.TYPE.BOOL},
		{name = "flags_unshaded",type = pro.TYPE.BOOL},
		{name = "flags_fixed_size",type = pro.TYPE.BOOL}
	])
	
	propriety("Parameters",[
		{name = "params_diffuse_mode",type = pro.TYPE.OPTION,options = ["Burley","Lambert","Lambert Warp","Oren Nayar","Toon"]},
		{name = "params_specular_mode",type = pro.TYPE.OPTION,options = ["SchlickGGX","Blinn","Phong","Toon","Disabled"]},
		{name = "params_blend_mode",type = pro.TYPE.OPTION,options = ["Mix","Add","Sub","Mul"]},
		{name = "params_cull_mode",type = pro.TYPE.OPTION,options = ["Fron","Back","Disabled"]},
		{name = "params_billboard_mode",type = pro.TYPE.OPTION,options = ["Disabled","Enabled","Y-Billboard"]},
		{name = "params_billboard_keep_scale",type = pro.TYPE.BOOL}
	])
	
	propriety("Albedo",[
		{name = "albedo_color",type = pro.TYPE.COLOR},
		{name = "albedo_texture",type = pro.TYPE.TEXTURE}
	])
	
	propriety("Metalic",[
		{name = "metalic",type = pro.TYPE.NUM,values = [0,1]},
		{name = "metallic_specular",type = pro.TYPE.NUM,values = [0,1]}
	])
	
	propriety("Roughness",[
		{name = "roughness",type = pro.TYPE.NUM,values = [0,1]},
		{name = "roughness_texture",type = pro.TYPE.TEXTURE}
	])
	
	propriety("Emission",[
		{name = "emission_enabled",type = pro.TYPE.BOOL},
		{name = "emission",type = pro.TYPE.COLOR},
		{name = "emission_energy",type = pro.TYPE.NUM,values = [0,16]},
		{name = "emission_operator",type = pro.TYPE.OPTION,options = ["Add","Multiply"]},
		{name = "emission_texture",type = pro.TYPE.TEXTURE}
	])
	
	propriety("Normal Map",[
		{name = "normal_scale",type = pro.TYPE.NUM,values = [-16,16]},
		{name = "normal_texture",type = pro.TYPE.TEXTURE}
	])
	
	propriety("UV 1",[
		{name = "uv1_scale",type = pro.TYPE.VECTOR},
		{name = "uv1_offset",type = pro.TYPE.VECTOR},
		{name = "uv1_triplanar",type = pro.TYPE.BOOL}
	])


func propriety(tittle: String,propriety: Array) -> void:
	var prop = propriety_new.instance()
	prop.tittle = tittle
	prop.mat = mat
	prop.types = propriety
	
	
	Vbox.add_child(prop)

