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
	
	propriety("Albedo","albedo_color",pro.TYPE.COLOR)
	[[{}]]

#Você parou aqui, estava tentando achar uma maneira de criar uma função que encurtace o caminho para criar as propriedades

func propriety(tittle: String,propriety_name: String,type: int) -> void:
	var albedo = propriety_new.instance()
	albedo.tittle = "Albedo"
	albedo.mat = mat
	
	albedo.types.push_back(
		{name = "albedo_color",type = albedo.TYPE.COLOR}
	)
	albedo.types.push_back(
		{name = "albedo_texture",type = albedo.TYPE.TEXTURE}
	)
	
	Vbox.add_child(albedo)
	
	var metalic = propriety_new.instance()
	metalic.tittle = "Metalic"
	metalic.mat = mat
	
	metalic.types.push_back(
		{name = "metalic",type = metalic.TYPE.NUM}
	)
	metalic.types.push_back(
		{name = "metallic_specular",type = metalic.TYPE.NUM}
	)
	
	Vbox.add_child(metalic)
	
