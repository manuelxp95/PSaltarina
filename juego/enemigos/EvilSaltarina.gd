extends Area2D
signal inicio_batalla()
signal boss_muerte(jugador)
signal boss_damage(jugador)

onready var animaciones = $AnimationPlayer
onready var detectar_dano =$DetectarDano/HeadDamage

var hits = 3

func _ready():
	desactivar_particulas()
	activate_enemies(false)
	$AnimatedSprite.set_deferred("playing",false)
	

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	pass


func desactivar_particulas():
	$ParticulaHumo.emitting = false
	$ParticulaHumoPies.emitting=false
	$ParticlesExplocion.emitting=false


func activate_enemies(valor):
	if valor:
		yield(get_tree().create_timer(5.0),"timeout") 
		animaciones.play("spawn_enemies")
		$AnimatedSprite.set_deferred("playing",true)
		emit_signal("inicio_batalla")
	$AnimatedSprite/SuperNubon.set_deferred("visible",valor)
	$AnimatedSprite/SuperNubon/Sprite/RayCast2D.set_deferred("enabled",valor)
	$AnimatedSprite/SuperNubon2.set_deferred("visible",valor)
	$AnimatedSprite/SuperNubon2/Sprite/RayCast2D.set_deferred("enabled",valor)


func _on_DetectarDao_body_entered(body):
	hits -=1
	body.impulsar()
	if hits == 0:
		emit_signal("boss_muerte",body)
		destruirse()
	else:
		animaciones.play("damage")
		emit_signal("boss_damage",body)
		detectar_dano.set_deferred("disabled",true)
		yield(get_tree().create_timer(0.5),"timeout")
		detectar_dano.set_deferred("disabled",false)


func destruirse():
	animaciones.play("muerte")
	yield(get_tree().create_timer(1.0),"timeout")
	queue_free()
