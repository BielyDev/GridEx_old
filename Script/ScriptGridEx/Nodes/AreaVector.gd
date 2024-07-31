extends GNode

onready var vector_size: VBoxContainer = $Panel/Hbox/Size/Vector_Size
onready var vector_division: VBoxContainer = $Division/Hbox/Division/Vector_Division


var amount: int = 0
var item_selected: int = 0 setget change_item_selected
var size: Vector3 = Vector3() setget change_size
var division: Vector3 = Vector3() setget change_division

func _ready() -> void:
	vector_size.node = self
	vector_size.propriety = "size"
	
	vector_division.node = self
	vector_division.propriety = "division"

#--------------
func create_area(index: int) -> void:
	match index:
		0:
			var plane = []
			
			for x in size.x:
				for z in size.z:
					plane.append(Vector3(x,0,z))
			
			self.value = plane
			#print(plane)
		1:
			var cube = []
			
			for x in size.x:
				for y in size.y:
					for z in size.z:
						cube.append(Vector3(x,y,z))
			
			self.value = cube


#--------------
func change_size(_value: Vector3) -> void:
	size = _value
	
	change_item_selected(item_selected)

func change_item_selected(index: int) -> void:
	item_selected = index
	
	create_area(index)

func change_division(_value: Vector3) -> void:
	division = _value
#--------------
func _on_AreaVector_from_value(new_value) -> void:
	amount = new_value.node.value

func _on_Model_item_selected(index: int) -> void:
	self.item_selected = index
