extends Node

class_name GridEx , "res://Assets/2D/Program/Icon/icon.svg"

static func create_time(sec: float = 1.0) -> Timer:
	var time = Timer.new()
	Index.add_child(time)
	
	time.wait_time = sec
	time.start()
	
	return time

static func delete_file(path: String) -> void:
	var dic = Directory.new()
	dic.remove(path)

static func string_to_vector(vector_str: String) -> Vector3:
	var sem_aspas: String = (vector_str.replace("(","").replace(")",""))
	var pos_string = sem_aspas.replace(",","")
	
	var pos_vect = Vector3(
		float(pos_string.split(" ")[0]),
		float(pos_string.split(" ")[1]),
		float(pos_string.split(" ")[2])
		)
	
	return pos_vect

static func string_to_color(color_str: String) -> Color:
	var sem_aspas: String = (color_str.replace("(","").replace(")",""))
	var color_string = sem_aspas.replace(",","")
	
	print(sem_aspas[0])
	var color = Color(
		float(sem_aspas.split(",")[0]),
		float(sem_aspas.split(",")[1]),
		float(sem_aspas.split(",")[2]),
		float(sem_aspas.split(",")[3])
		)
	
	return color


static func new_settings_popup() -> Popup:
	var pop = preload("res://Scene/UI/Resources/Settings_Popup.tscn")
	
	var new_pop = pop.instance()
	
	return new_pop
	
