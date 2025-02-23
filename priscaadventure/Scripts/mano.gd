extends Node2D


const LARGHEZZA_CARTA=200
const POSIZIONE_Y_MANO= 890

var speed=0.5

var mano=[]
var indicemano=0
var center_screen_x

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	center_screen_x=get_viewport().size.x/2
	
func aggiungi_carta(carta, speed):
	if carta not in mano:
		mano.insert(0,carta)
		aggiorna_pos_mano(speed)
	else:
		anima_carta_posizione(carta,carta.posizione_iniziale,speed)

func aggiorna_pos_mano(speed):
	for i in range(mano.size()):
		var nuova_posizione=Vector2(calcola_posizione_carta(i), POSIZIONE_Y_MANO)
		var carta=mano[i]
		carta.posizione_iniziale= nuova_posizione
		anima_carta_posizione(carta,nuova_posizione,speed)
	

func anima_carta_posizione(carta,p,speed):
	var tween=get_tree().create_tween()
	tween.tween_property(carta,"position", p,speed)

func calcola_posizione_carta(index):
	var larghezza_totale=(mano.size()-1)*LARGHEZZA_CARTA
	var x_offset=center_screen_x+index*LARGHEZZA_CARTA-larghezza_totale/2
	return x_offset

func rimuovi_carta(carta):
	if carta in mano:
		mano.erase(carta)
		aggiorna_pos_mano(speed)
	
