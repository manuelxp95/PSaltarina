extends Node
signal abrir_portal()

export var menu_game_over = "res://juego/Menus/MenuGameOver.tscn"
export var nivel_actual =""

var numero_llaves = 0
var contenedor_llaves 

onready var player = $Saltarina
onready var salt_ani = $Saltarina/AnimatedSprite
onready var nubes_lejanas = $ParallaxBackground/ParallaxNubesLejanas
onready var cutscene=$Cutscene/Camera2D
onready var hud_life= $CapaFrente/HUD/Lifebar

func _ready():
	save_level(nivel_actual)
	hud_life.set_deferred("visible",false)
	if DatosPlayer.cinematica == false:
		deshabilitar_jugador(false)
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
	DatosPlayer.cinematica = false
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_game_over)


func deshabilitar_jugador(camara_actual):
	$Cutscene/AnimationPlayer.play("show")
	player.get_node("Camera2D").current = camara_actual
	cutscene.current= !camara_actual
	player.puede_moverse=camara_actual


# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	deshabilitar_jugador(true)
	DatosPlayer.cinematica = true


#save
func save_level(nivel_actual) -> void:
	var nro_lvl= nivel_actual.substr(25,1)
	if SaveMaster.data["MaxLevel"]< int(nro_lvl):
		SaveMaster.data["MaxLevel"] +=1
		SaveMaster.save_data()
		print(SaveMaster.data["MaxLevel"])
	
