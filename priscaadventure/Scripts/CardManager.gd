extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_CARD_SLOT = 2
var carta_sposta = null
var dim_screen
var is_hover_carta
var mano_reference
var speed = 0.3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dim_screen = get_viewport_rect().size
	mano_reference = $"../Mano"
	$"../InputManager".connect("left_mouse_button_released", left_released)
	#$"../Deck".pesca_carta(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if carta_sposta:
		var pos_mouse = get_global_mouse_position()
		carta_sposta.position = Vector2(
			clamp(pos_mouse.x, 0, dim_screen.x), clamp(pos_mouse.y, 0, dim_screen.y)
		)


#chiamata al click del mouse
#func _input(event):
#if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
#if event.pressed:
#var carta=spostamento()
#if carta:
#inizio_spostamento(carta)
#else:
#if carta_sposta:
#fine_spostamento()


func inizio_spostamento(carta):
	carta_sposta = carta
	carta.scale = Vector2(1, 1)


func fine_spostamento():
	carta_sposta.scale = Vector2(1.2, 1.2)
	var slot_carta_trovata = spostamento_slot()
	#se non c'è nessuna carta nello slot n allora la inserisce
	if slot_carta_trovata and not slot_carta_trovata.carta_in_slot:
		mano_reference.rimuovi_carta(carta_sposta)
		carta_sposta.position = slot_carta_trovata.position
		carta_sposta.get_node("Area2D/CollisionShape2D").disabled = true
		slot_carta_trovata.carta_in_slot = true
	else:
		mano_reference.aggiungi_carta(carta_sposta, speed)
	carta_sposta = null


func spostamento_slot():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD_SLOT
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#controllo su z-index di hover
		return result[0].collider.get_parent()
	else:
		return null


func spostamento():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#controllo su z-index di hover
		return carta_maggiore_z_index(result)
	else:
		return null


#permette di selezionare e rispostare la carta con z-index più alto, quindi la carta già hoverata
func carta_maggiore_z_index(carte):
	var carta_maggiore_z = carte[0].collider.get_parent()
	var maggiore_z_index = carta_maggiore_z.z_index
	for i in range(1, carte.size()):
		var carta_corrente = carte[i].collider.get_parent()
		if carta_corrente.z_index > maggiore_z_index:
			maggiore_z_index = carta_corrente.z_index
			carta_maggiore_z = carta_corrente
	print(carta_maggiore_z)
	return carta_maggiore_z


func connetti_carta(carta):
	carta.connect("hovered", carta_hover)
	carta.connect("hovered_off", carta_non_hover)


func left_released():
	if carta_sposta:
		fine_spostamento()


func carta_hover(carta):
	if !is_hover_carta:
		is_hover_carta = true
		effetto_hover(carta, true)


func carta_non_hover(carta):
	effetto_hover(carta, false)
	var nuova_carta_hover = spostamento()
	if nuova_carta_hover:
		effetto_hover(nuova_carta_hover, true)
	else:
		is_hover_carta = false


func effetto_hover(carta, hovered):
	if hovered:
		carta.scale = Vector2(1.2, 1.2)
		carta.z_index = 2
	else:
		carta.scale = Vector2(1, 1)
		carta.z_index = 1
