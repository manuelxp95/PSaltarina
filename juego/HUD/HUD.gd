extends Control

onready var etiqueta_vidas = $ContenedorVidas/Cantidad
onready var etiqueta_moneda_bronce =$ContenedorMonedaBronce/Cantidad
onready var etiqueta_moneda_plata=$ContenedorMonedaPlata/Cantidad
onready var etiqueta_moneda_oro=$ContenedorMonedaOro/Cantidad
onready var etiqueta_llaves = $ContenedorLlaves/Cantidad
#------------lifebar-----------
onready var lifebar=$Lifebar

func _ready():
# warning-ignore:return_value_discarded
	DatosPlayer.connect("actualizar_datos",self,"actualizar_hud")
	actualizar_hud()
	#----------inicial lifebar -------
	for bar in lifebar.get_children():
		bar.set_deferred("visible",true)

func actualizar_hud():
	etiqueta_vidas.text = "%s" %DatosPlayer.vidas
	etiqueta_moneda_bronce.text="%s" %DatosPlayer.moneda_bronce
	etiqueta_moneda_plata.text="%s" %DatosPlayer.moneda_plata
	etiqueta_moneda_oro.text="%s" %DatosPlayer.moneda_oro
	etiqueta_llaves.text="%s" %DatosPlayer.llaves

