extends Node2D

const CARTA_SCENA_PATH = "res://scene/cartaAvversario.tscn"
const starting_cards_n = 3
var deck_giocatore1 = ["RantuBase", "CezarBase", "AndreBase", "AngeloBase", "RisiBase"]
var turno=false


var CardDB_reference
var speed = 0.3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck_giocatore1.shuffle()
	$Area2D/RichTextLabel.text = str(deck_giocatore1.size())
	#$"../Avversario/Deck/Area2D/RichTextLabel".text = str(deck_giocatore2.size())
	CardDB_reference = preload("res://Scripts/CardDB.gd")
	
	for i in range(starting_cards_n):
		pesca_carta()
		await get_tree().create_timer(0.6).timeout

		#aggiungere pesca avversario


func pesca_carta(n: int = 1) -> void:
	var carta_uscita = deck_giocatore1[0]

	var carta_scena = preload(CARTA_SCENA_PATH)
	for i in range(n):
		if deck_giocatore1:
			var nuova_carta = carta_scena.instantiate()
			set_carta(nuova_carta, carta_uscita)
			$"../CardManager".add_child(nuova_carta)
			nuova_carta.name = "Carta"
			nuova_carta.get_node("AnimationPlayer").play("Draw_Card")
			await get_tree().create_timer(0.3).timeout
			$"../ManoAvversario".aggiungi_carta(nuova_carta, speed)
			print("rantu merda")
			turno=true
		else:
			break
	deck_giocatore1.erase(carta_uscita)
	#fa sparire deck
	if deck_giocatore1.size() == 0:
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
	$Area2D/RichTextLabel.text = str(deck_giocatore1.size())


func set_carta(carta, carta_uscita):
	var immagine_carta_path = str("res://Assets/immaginiCarte/" + carta_uscita + ".png")
	carta.get_node("Image").texture = load(immagine_carta_path)
	carta.get_node("Mana").text = str(CardDB_reference.CARTE[carta_uscita][1])
	carta.get_node("Attacco").text = str(CardDB_reference.CARTE[carta_uscita][2])
	carta.get_node("Difesa").text = str(CardDB_reference.CARTE[carta_uscita][3])
	carta.get_node("Effetto").text = str(CardDB_reference.CARTE[carta_uscita][4])
