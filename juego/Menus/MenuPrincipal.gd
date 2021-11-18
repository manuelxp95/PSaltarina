extends Control

func _ready():
	DatosPlayer.reset()


func _on_BotonIniciar_pressed():
	MusicaGlobal.replay()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://juego/niveles/Nivel1_v2.tscn")


func _on_BotonNiveles_pressed():
	get_tree().change_scene("res://juego/Menus/SelectLevel.tscn")

