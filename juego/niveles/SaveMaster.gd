extends Node

const SAVE_DIR ="user://saves/"

var save_path = SAVE_DIR + "save.dat"

var data = {}

func _ready():
	load_data()

#load lvl
func load_data():
	var file = File.new()
	if not file.file_exists(SaveMaster.save_path):
		# CREATE SAVE.DATA
		var dir = Directory.new()
		if !dir.dir_exists(SAVE_DIR):
			dir.make_dir_recursive(SAVE_DIR)
		var error = file.open(save_path, File.WRITE)
		if error == OK:
			data={"MaxLevel": 1}
			file.store_var(data)
	else:
		file.open(save_path,File.READ)
		data= file.get_var()
	file.close()


#save data
func save_data():
	var file=File.new()
	file.open(save_path,File.WRITE)
	file.store_var(data)
	file.close()



