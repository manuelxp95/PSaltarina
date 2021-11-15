extends Node2D

onready var detector_jugador= $Sprite/RayCast2D
onready var posiciones_disparo= $Sprite/PosicionesDisparo
onready var cadencia_disparo = $Timer
onready var sfx_rayos=$rayos

export var rayo: PackedScene 

var puede_dis= true

# warning-ignore:unused_argument
func _process(_delta):
	if detector_jugador.is_colliding() and puede_dis:
		disparar()
		puede_dis=false
		cadencia_disparo.start()


func disparar():
	sfx_rayos.play()
	for posicion in posiciones_disparo.get_children():
		var nuevo_rayo = rayo.instance()
		nuevo_rayo.crear(posicion.global_position)
		owner.get_node("Rayos").add_child(nuevo_rayo)


func _on_Timer_timeout():
	puede_dis=true
