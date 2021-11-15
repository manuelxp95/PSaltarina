extends Area2D

onready var detector_jugador = $DetectorJugador
onready var detector_pisoton = $DetectorPisoton/Colisionador
onready var animacion = $AnimationPlayer3

func _on_DetectorPisoton_body_entered(body):
	desactivar_colisionadres([detector_jugador,detector_pisoton])
	animacion.stop()
	animacion.play("morir")
	body.impulsar()


func _on_body_entered(body):
	body.respawn()


func desactivar_colisionadres(colisionadores):
	for colision in colisionadores: 
		detector_jugador.set_deferred ("disabled", true)
		detector_jugador.set_deferred("visible", false)
