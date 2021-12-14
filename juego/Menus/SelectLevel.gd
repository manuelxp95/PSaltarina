extends Control

var player_data

func _ready():
	player_data = SaveMaster.data["MaxLevel"]
	lvlUnlocked(player_data)


func lvlUnlocked(save):
	var cont = 1
	for child in $MarginContainer/GridContainer.get_children():
		if (cont <= save) && (child.text == ("lvl "+ str(cont))):
			child.disabled= false
			cont += 1

func _on_BotonMenu_pressed():
	get_tree().change_scene("res://juego/Menus/MenuPrincipal.tscn")

func _on_Botonlvl1_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel1_v2.tscn")

func _on_Botonlvl2_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel2.tscn")


func _on_Botonlvl3_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel3.tscn")


func _on_Botonlvl4_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel4.tscn")


func _on_Botonlvl5_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel5.tscn")


func _on_Botonlvl6_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel6.tscn")


func _on_Botonlvl7_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel7.tscn")


func _on_Botonlvl8_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel8.tscn")


func _on_Botonlvl9_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel9.tscn")


func _on_Botonlvl10_pressed():
	get_tree().change_scene("res://juego/niveles/Nivel10.tscn")
