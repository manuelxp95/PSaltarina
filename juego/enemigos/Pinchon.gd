extends KinematicBody2D

export var velocidad =100.0

var gravedad= 800.0
var movimiento = Vector2.ZERO

onready var animacion =$AnimatedSprite
onready var dec_vacio=$AnimatedSprite/DetectorVacio
onready var dec_pared = $DetectorPared

func _physics_process(_delta):
	caer()
	caminar()
# warning-ignore:return_value_discarded
	move_and_slide(movimiento,Vector2.UP)
 
func caer():
	if not is_on_floor():
		movimiento.y = gravedad
		
func caminar():
	if not animacion.is_playing():
		animacion.play("caminar")
	detectar_colision()
	movimiento.x = velocidad
	
func detectar_colision():
	if not dec_vacio.is_colliding() or dec_pared.is_colliding():
		velocidad *= -1
		dec_pared.position *= -1
		dec_pared.scale.x *= -1
		animar()

func animar():
	animacion.scale.x *= -1

func _on_DetectorJugador_body_entered(body):
	body.respawn()
