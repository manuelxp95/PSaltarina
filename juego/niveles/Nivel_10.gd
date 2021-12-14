extends Node
signal abrir_portal()

export var menu_game_over = "res://juego/Menus/MenuGameOver.tscn"
export var nivel_actual ="res://juego/niveles/Nivel10.tscn"

var numero_llaves = 0
var contenedor_llaves 

#-----Boss variales----
onready var player = $Saltarina
onready var salt_ani = $Saltarina/AnimatedSprite
onready var evil_salt_ani=$Enemigos/EvilSaltarina/AnimationPlayer
onready var evil_salt =$Enemigos/EvilSaltarina
onready var nubes_lejanas = $ParallaxBackground/ParallaxNubesLejanas
onready var cutscene_boss=$Cutscene/Camera2D
onready var hud_life= $CapaFrente/HUD/Lifebar

func _ready():
	save_level()
	#-------Nivel 10 conexiones -------
	if nivel_actual == "res://juego/niveles/Nivel10.tscn":
		deshabilitar_pared(true)
		evil_salt.connect("boss_damage",self,"boss_damage")
		evil_salt.connect("boss_damage",self,"expulsar_jugador")
		evil_salt.connect("boss_muerte",self,"boss_muerte")
		evil_salt.connect("inicio_batalla",self,"respawn_boss")
	hud_life.set_deferred("visible",false)
	#----------------------------------
	
# warning-ignore:return_value_discarded
	DatosPlayer.connect("game_over",self,"game_over")
	contenedor_llaves = get_node_or_null("Zanahorias")
	if contenedor_llaves != null:
		numero_llaves_nivel()


func _process(_delta):
	nubes_lejanas.motion_offset.x -=0.3


func numero_llaves_nivel():
	numero_llaves= contenedor_llaves.get_child_count()
	DatosPlayer.contabilizar_llaves(numero_llaves)
	for llave in contenedor_llaves.get_children():
		llave.connect("consumida", self, "llaves_restantes")


func llaves_restantes():
	numero_llaves -= 1
	if numero_llaves ==0 :
		emit_signal("abrir_portal")


func game_over():
	DatosPlayer.nivel_actual=nivel_actual
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_game_over)


#-------------------------NIVEL10-----------------------------
# warning-ignore:unused_argument
func _on_body_entered(body):
	MusicaGlobal.stop_music()
	$Trigger/Area2D/DetectarJugador.set_deferred("disabled", true)


# warning-ignore:unused_argument
func _on_Area2D2_body_entered(body):
	#----------------- Inicio cutscene ----------------------
	salt_ani.play("idle")
	MusicaGlobal.boss_song()
	$Trigger/Area2D2/DetectarJugador.set_deferred("disabled", true)
	$Cutscene/AnimationPlayer.play("boss_spawn")
	deshabilitar_jugador(false)
	#---------------Animacion de spawn----------------
	yield(get_tree().create_timer(16.0),"timeout")
	evil_salt_ani.play("spawn")
	deshabilitar_pared(false)
	hud_life.set_deferred("visible",true)


func deshabilitar_jugador(camara_actual):
	player.get_node("Camera2D").current = camara_actual
	cutscene_boss.current= !camara_actual
	player.puede_moverse=camara_actual
	

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	deshabilitar_jugador(true)


func deshabilitar_pared(activado):
	$Trigger/ParedIzq/ParedeNiebla.set_deferred("disabled",activado)
	$Trigger/ParedIzq/Particles2D.emitting = !activado

# warning-ignore:unused_argument
func boss_damage(jugador):
	if evil_salt.hits == 2:
		hud_life.get_node("BarFull").set_deferred("visible",false)
	elif evil_salt.hits == 1:
		hud_life.get_node("Bar2-3").set_deferred("visible",false)
	elif evil_salt.hits == 0:
		hud_life.get_node("Bar1-3").set_deferred("visible",false)

func boss_muerte(jugador):
	hud_life.set_deferred("visible",false)
	jugador.expulsado($Trigger/PosicionSalida.global_position)
	jugador.puede_moverse=true
	jugador.animacion_personaje.play("default")
	MusicaGlobal.replay()


func expulsar_jugador(jugador):
	jugador.expulsado($Trigger/PosicionRespawn.global_position)
	jugador.puede_moverse=true

func respawn_boss():
	player.batalla_boss=$Trigger/PosicionRespawn.global_position

func save_level():
	if SaveMaster.data["MaxLevel"] < 10:
		SaveMaster.data["MaxLevel"] +=1
		SaveMaster.save_data()
