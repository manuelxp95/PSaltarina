extends Control

func _ready():
	var file = File.new()
	if file.file_exists(SaveMaster.save_path):
		var error = file.open_encrypted_with_pass(SaveMaster.save_path, File.READ, "OmarEsUnGrande")
		if error == OK:
			var player_data = file.get_var()
			print(player_data)
			lvlUnlocked(player_data)
			file.close()

func lvlUnlocked(save):
	var cont = 1
	for i in save:
		if save[i] == true :
			unlocked_button(cont)
		cont+=1

func _on_BotonMenu_pressed():
	get_tree().change_scene("res://juego/Menus/MenuPrincipal.tscn")

func _on_Botonlvl1_pressed():
	print("entre aca")
	get_tree().change_scene("res://juego/niveles/Nivel1_v2.tscn")

func unlocked_button(nro_button):
	for child in $MarginContainer/GridContainer.get_children():
		if child.text == ("lvl "+ str(nro_button)):
			child.disabled= false
			print ("llegue")
