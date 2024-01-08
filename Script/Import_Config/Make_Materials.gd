extends Node

onready var Mat: VBoxContainer = $"%Materials"

var Material_edit_new: PackedScene = preload("res://Scene/Import/Material_edit.tscn")


func make(item_select: MeshInstance) -> void:
	create_surface_material_menu(item_select)
	create_sep()
	create_geometry_material_menu(item_select)


func clear() -> void:
	for child in Mat.get_children():
		child.queue_free()


func create_sep() -> void:
	var Sep: HSeparator = HSeparator.new()
	Mat.add_child(Sep)


func create_surface_material_menu(item_select: MeshInstance) -> void:
	for passos in item_select.mesh.get_surface_count():
		var Material_menu = Material_edit_new.instance()
		var mat: SpatialMaterial = item_select.mesh.surface_get_material(passos)
		
		Material_menu.tittle = str("Surface Material/",passos)
		Material_menu.mat = mat
		Mat.add_child(Material_menu)


func create_geometry_material_menu(item_select: MeshInstance) -> void:
	var Material_menu_override = Material_edit_new.instance()
	var Material_menu_overlay = Material_edit_new.instance()
	
	var mat_override: SpatialMaterial = item_select.material_override
	var mat_overlay: SpatialMaterial = item_select.material_overlay
	
	Material_menu_override.tittle = "Material Override"
	Material_menu_overlay.tittle = "Material Overlay"
	
	Material_menu_override.mat = mat_override
	Material_menu_overlay.mat = mat_overlay
	
	Mat.add_child(Material_menu_override)
	Mat.add_child(Material_menu_overlay)
