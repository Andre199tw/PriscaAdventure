extends Node2D

const HAND_COUNT=8
const CARTA_SCENA_PATH = "res://scene/carta.tscn"
const LARGHEZZA_CARTA=200
const POSIZIONE_Y_MANO= 890


var mano=[]
var indicemano=0
var center_screen_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_screen_x=get_viewport().size.x/2
	var carta_scena=preload(CARTA_SCENA_PATH)
	for i in range(HAND_COUNT):
		var nuova_carta=carta_scena.instantiate()
		$"../CardManager".add_child(nuova_carta)
		nuova_carta.name = "Carta"
		aggiungi_carta(nuova_carta)

func aggiungi_carta(carta):
	mano.insert(0,carta)
	aggiorna_pos_mano(mano)

func aggiorna_pos_mano(mano):
	for i in range(mano.size()):
		var nuova_posizione=Vector2(calcola_posizione_carta(i), POSIZIONE_Y_MANO)
		var carta=mano[i]
		anima_carta_posizione(carta,nuova_posizione)
	

func anima_carta_posizione(carta,p):
	var tween=get_tree().create_tween()
	tween.tween_property(carta,"position", p,0.1)

func calcola_posizione_carta(index):
	var larghezza_totale=(mano.size()-1)*LARGHEZZA_CARTA
	var x_offset=center_screen_x+index*LARGHEZZA_CARTA-larghezza_totale/2
	return x_offset

	
