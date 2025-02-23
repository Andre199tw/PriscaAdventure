extends Node2D


const CARTA_SCENA_PATH = "res://scene/carta.tscn"
var deck_giocatore=["Rantu", "Rantu", "Rantu"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func disegna_carta(n):
	var carta_uscita=deck_giocatore[0]
	deck_giocatore.erase(carta_uscita)
	
	#fa sparire deck
	if deck_giocatore.size()==0:
		$Area2D/CollisionShape2D.disabled=true
		$Sprite2D.visible=false
	
	var carta_scena=preload(CARTA_SCENA_PATH)
	#for i in range(n):
	if deck_giocatore:
		var nuova_carta=carta_scena.instantiate()
		$"../CardManager".add_child(nuova_carta)
		nuova_carta.name = "Carta"
		$"../Mano".aggiungi_carta(nuova_carta)
	

	print("rantu merda")
