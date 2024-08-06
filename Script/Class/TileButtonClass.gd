extends AnimationButtonClass

class_name TileButton


var Up: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Up.tres")
var Reload: AtlasTexture = preload("res://Assets/2D/Atlas/UI/Reload_icon_tile.tres")


var Tile: Tile
var id_text = Label.new()
var popup = true
var new_popup
var parent
var is_pressed: bool = false
var timer: Timer = Timer.new()

func _ready() -> void:
	connect("gui_input",self,"_settings_popup")
	connect("child_exiting_tree",self,"reset_pop")
	connect("button_down",self,"_down_button")
	connect("button_up",self,"_up_button")
	
	add_child(timer)
	
	timer.wait_time = 0.2
	timer.one_shot = true
	timer.connect("timeout",self,"_timer_pressed")
	
	
	center_pivot()
	speed = 0.2
	
	add_child(id_text)
	id_text.hide()
	id_text.text =  str(Tile.id_tile)


func index() -> void:
	Index.tile.id_tile = Tile.id_tile
	Index.tile.id_group = Tile.id_group
	Index.tile.icon = icon


func _settings_popup(_event: InputEvent) -> void:
	if _event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_RIGHT) and popup:
			grab_focus()
			
			new_popup = GridEx.new_settings_popup()
			add_child(new_popup)
			buttons_popup(new_popup)
			popup = false


func reset_pop(child: Node) -> void:
	popup = true


func buttons_popup(popup: CanvasLayer) -> void:
	popup.create_button(self,"First tile","first_tile",Up)
	popup.create_button(self,"Reload icon","reload_icon",Reload)

func first_tile() -> void:
	get_parent().move_child(self,0)
	new_popup.hide()

func reload_icon() -> void:
	get_parent().get_parent().get_parent().get_parent().get_parent().generate_icon(Tile,self,5)
	new_popup.hide()


# Drag drop ===============

func _input(event: InputEvent) -> void:
	#Android ===============================
	if event is InputEventScreenTouch:
		if event.pressed == false:
			if pressed:
				reset_slot()
			else:
				move_slot()
	#========================================
	
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		if is_pressed:
			rect_global_position = get_global_mouse_position() - (rect_size/2)
			parent.slot = self
		
		else:
			
			if Input.is_action_just_released("click_left") and is_instance_valid(parent.slot):
				move_slot()
		
		if is_pressed:
			if Input.is_action_just_released("click_left"):
				reset_slot()


func move_slot() -> void:
	if parent.slot != self:
		if (parent.slot.rect_global_position - (parent.slot.rect_size/2)).distance_to(rect_global_position - (rect_size/2)) < (rect_size.x-20):
			var index = get_index()
			
			get_parent().move_child(self,parent.slot.get_index())
			get_parent().move_child(parent.slot,index)
			
			get_parent().queue_sort()
			
			parent.slot = null

func reset_slot() -> void:
	yield(get_tree(),"idle_frame")
	
	if parent.slot == self:
		get_parent().queue_sort()
		parent.slot = null


func _down_button() -> void:
	timer.start()

func _up_button() -> void:
	
	timer.stop()
	is_pressed = false


func _timer_pressed() -> void:
	is_pressed = true
