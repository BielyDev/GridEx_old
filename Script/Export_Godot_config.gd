extends Control

signal final()

var dir
onready var collision: CheckButton = $Panel/Vbox/Panel/Options/Collision/Collision
onready var collision_mode: OptionButton = $Panel/Vbox/Panel/Options/Collision/CollisionMode
onready var light: CheckButton = $Panel/Vbox/Panel/Options/Light/Light
onready var tile: CheckButton = $Panel/Vbox/Panel/Options/Mesh/Tile
onready var tile_mode: OptionButton = $Panel/Vbox/Panel/Options/Mesh/Hbox/TileMode


func _process(delta: float) -> void:
	Index.block_view = true

func _on_Export_pressed() -> void:
	Export.export_tscn(str(dir,".tscn"),collision.pressed,collision_mode.selected,light.pressed,tile.pressed,tile_mode.selected)
	
	emit_signal("final")
	Index.block_view = false
	queue_free()
