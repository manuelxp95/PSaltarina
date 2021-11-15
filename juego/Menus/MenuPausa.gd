extends Control

func _ready():
	visible=false

func _input(event):
	if event.is_action_pressed("pausa"):
		visible = !visible
		get_tree().paused= !get_tree().paused


func _on_BotonContinuar_pressed():
	get_tree().paused=false
	visible = !visible


func _on_BotonMenuPrincipal_pressed():
	get_tree().paused=false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://juego/Menus/MenuPrincipal.tscn")
