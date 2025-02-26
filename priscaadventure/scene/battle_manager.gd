extends Node

var battle_timer
var slot_vuoti=[]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	battle_timer=$"../BattleTimer"
	battle_timer.one_shot=true
	battle_timer.wait_time= 1.0
	
	
	#contrassegna gli slot riempibili
	#sostituire successivamente con assegnazione posizione carta automatica con scaling automatico
	slot_vuoti.append($"../SlotMaster/EnemyCardSlot1")
	slot_vuoti.append($"../SlotMaster/EnemyCardSlot2")
	slot_vuoti.append($"../SlotMaster/EnemyCardSlot3")


func _on_fine_turno_pressed() -> void:
	turno_avversario()




func turno_avversario():
	$"../fine turno".disabled=true
	$"../fine turno".visible=false
	
	#aggiungere in BM diramificazione per giocatore 1 o 2
	$"../Avversario".pesca_carta()
	
	battle_timer.start()
	await battle_timer.timeout
	
	
	#da sostituire con battaglia
	if slot_vuoti.size()==0:
		
		fine_turno_avversario()
		return
	
	
	
	fine_turno_avversario()
	#end turn


func fine_turno_avversario():
	
	#reset deck
	$"../fine turno".disable=false
	$"../fine turno".visible=true
