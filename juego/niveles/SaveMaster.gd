extends Node

const SAVE_DIR ="user://saves/"

var save_path = SAVE_DIR + "save.dat"

var data ={
	"lvl1": true,
	"lvl2": true,
	"lvl3": false,
	"lvl4": false,
	"lvl5": false,
	"lvl6": false,
	"lvl7": false,
	"lvl8": false,
	"lvl9": false,
	"lvl10": true
}

func _ready():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, "OmarEsUnGrande")
	if error == OK:
		file.store_var(data)
		file.close()

	
