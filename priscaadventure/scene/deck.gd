extends Node2D


const CARTA_SCENA_PATH = "res://scene/carta.tscn"
var deck_giocatore=["RantuBase", "CezarBase","AndreBase"]#, "AngeloBase","RisiBase"]
var CardDB_reference
var speed=0.3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck_giocatore.shuffle()
	$Area2D/RichTextLabel.text=str(deck_giocatore.size())
	CardDB_reference=preload("res://Scripts/CardDB.gd")




func disegna_carta(n=1):
	var carta_uscita=deck_giocatore[0]
	
	var carta_scena=preload(CARTA_SCENA_PATH)
	for i in range(1):
		if deck_giocatore:
			var nuova_carta=carta_scena.instantiate()
			set_carta(nuova_carta,carta_uscita)
			$"../CardManager".add_child(nuova_carta)
			nuova_carta.name = "Carta"
			$"../Mano".aggiungi_carta(nuova_carta, speed)
			print("rantu merda")
		else:
			break
	deck_giocatore.erase(carta_uscita)
	#fa sparire deck
	if deck_giocatore.size()==0:
		$Area2D/CollisionShape2D.disabled=true
		$Sprite2D.visible=false
	$Area2D/RichTextLabel.text=str(deck_giocatore.size())


func set_carta(carta,carta_uscita):
	var immagine_carta_path=str("res://Assets/immaginiCarte/"+carta_uscita+".png")
	carta.get_node("Image").texture=load(immagine_carta_path)
	carta.get_node("Mana").text=str(CardDB_reference.CARTE[carta_uscita][1])
	carta.get_node("Attacco").text=str(CardDB_reference.CARTE[carta_uscita][2])
	carta.get_node("Difesa").text=str(CardDB_reference.CARTE[carta_uscita][3])
	carta.get_node("Effetto").text=str(CardDB_reference.CARTE[carta_uscita][4])
	
