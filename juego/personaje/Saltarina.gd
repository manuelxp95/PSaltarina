extends KinematicBody2D

#----------------variables globales------------------

export var vel= Vector2(150.0,150.0)
export var acel_caida= 400
export var fuerza_salto= 3000
export var fuerza_revote =350
export var impulso = -3800

#-----------------variables locales---------------------

var movimiento= Vector2.ZERO
var fuerza_salto_original
var acel_caida_original
var puede_moverse =true
var batalla_boss = Vector2.ZERO

#--------------Otros nodos-------------------

onready var animacion = $AnimatedSprite
onready var audio_salto = $AudioSalto
onready var camara = $Camera2D
onready var enfriamiento_power_up =$EnfriamentoPoweUpSalto
onready var enfriamiento_power_up_volar =$EnfriamientoPowerUpVolar
onready var animacion_personaje =$AnimationPlayer
onready var collision=$CollisionCuerpo
onready var collisionpies=$CollisionPies

func _ready():
	animacion_personaje.play("aclarar")
	fuerza_salto_original= fuerza_salto
	acel_caida_original=acel_caida

func _physics_process(_delta):
	movimiento.x = vel.x *tomar_direccion()
	caer()
	saltar()
	colision_techo()
	caida_al_vacio()
	
# warning-ignore:return_value_discarded
	move_and_slide(movimiento,Vector2.UP)


# ------------------------------- FUNCIONES SALTARINA --------------------------------------
func tomar_direccion():
	var dir =0
	if puede_moverse:
		dir =Input.get_action_strength("mov_derecha")-Input.get_action_strength("mov_izquierda")
		if dir == 0:
			animacion.play("idle")
		elif dir < 0:
			animacion.flip_h = true
			animacion.play("correr")
		else:
			animacion.flip_h = false
			animacion.play("correr")
	return dir

func caer():
	if not is_on_floor():
		animacion.play("saltar")
		movimiento.y += acel_caida
		movimiento.y = clamp(movimiento.y, impulso, vel.y)
		
func saltar():
	if Input.is_action_just_pressed("salto") && is_on_floor() && puede_moverse:
		audio_salto.play()
		animacion.play("saltar")
		saltar_movimiento()

func saltar_movimiento():
	movimiento.y = 0
	movimiento.y -= fuerza_salto
	
func colision_techo():
	if is_on_ceiling():
		movimiento.y = fuerza_revote


func respawn():
	DatosPlayer.restar_vidas()
	animacion_personaje.play("oscurecer")
	
	#----------------------------------
	if batalla_boss !=Vector2.ZERO:
		collision.set_deferred("disabled",true)
		collisionpies.set_deferred("disabled",true)
		expulsado(batalla_boss)
		yield(get_tree().create_timer(1.0),"timeout")
		animacion_personaje.play("aclarar")
		collision.set_deferred("disabled",false)
		collisionpies.set_deferred("disabled",false)
		puede_moverse=true
	#----------------------------------
	
	elif DatosPlayer.vidas >= 1:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func cambiar_fuerza_salto():
	enfriamiento_power_up.start()
	fuerza_salto = -impulso * 0.9

func caida_al_vacio():
	if position.y > camara.limit_bottom:
		respawn()

func impulsar():
	movimiento.y = impulso 

func volar():
	enfriamiento_power_up_volar.start()
	acel_caida =60
	animacion_personaje.play("volar")
	saltar_movimiento()

func play_entrar_portal(posicion_portal):
	animacion_personaje.play("entrar_portal")
	puede_moverse=false
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicion_portal,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
	)
	$Tween.start()

func _on_EnfriamentoPoweUp_timeout():
	fuerza_salto = fuerza_salto_original

func _on_EnfriamientoPowerUpVolar_timeout():
	acel_caida=acel_caida_original
	animacion_personaje.play("default")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entrar_portal":
		animacion_personaje.play("oscurecer")


func expulsado(posicion_expulcion):
	puede_moverse=false
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicion_expulcion,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
	)
	$Tween.start()
	animacion_personaje.play("expulsar")
	yield(get_tree().create_timer(2.5),"timeout")
