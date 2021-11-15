extends Area2D

onready var animacion= $AnimationPlayer
onready var detector_personaje = $CollisionShape2D

export var respawn = false

func _on_body_entered(body):
	aplicar_power_up(body)
	detector_personaje.set_deferred("disabled",true)
	animacion.play("consumir")
	if respawn:
		respawnear()

func respawnear():
	yield(get_tree().create_timer(5.0),"timeout")
	detector_personaje.set_deferred("disabled",false)
	animacion.play("idle")


# warning-ignore:unused_argument
func aplicar_power_up(body):
	pass
