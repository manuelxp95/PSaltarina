extends Area2D

export(String, "oro","plata","bronce") var tipo_moneda

onready var animacion = $AnimatedSprite
onready var ani_consumir = $AnimationPlayer
onready var colision_personaje = $CollisionShape2D

func _ready():
	animacion.play()
	
# warning-ignore:unused_argument
func _on_body_entered(body):
	DatosPlayer.sumar_monedas(tipo_moneda)
	colision_personaje.set_deferred("disabled",true)
	ani_consumir.play("consumir")
	
