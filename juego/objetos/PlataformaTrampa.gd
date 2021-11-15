extends StaticBody2D

onready var colisionador = $Colisionador

# warning-ignore:unused_argument
func _on_DetectorPersonaje_body_entered(body):
	$DetectorPersonaje/CollisionShape2D.set_deferred("disabled",true)
	$AnimationPlayer.play("caer")


func deshabilitar_colisionador():

	$Colisionador.set_deferred("disabled", true)
