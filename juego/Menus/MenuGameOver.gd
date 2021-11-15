extends Control

var nivel_actual =""

func _ready():
	DatosPlayer.reset()
	nivel_actual=DatosPlayer.nivel_actual


func _on_BotonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://juego/Menus/MenuPrincipal.tscn")


func _on_BotonReintentar_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_actual)
