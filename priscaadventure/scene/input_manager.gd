extends Node2D


signal left_mouse_button_clicked
signal left_mouse_button_released

const COLLISION_MASK_CARD=1
const COLLISION_MASK_DECK=4

var deck_reference
var card_manager_reference

func _ready() -> void:
	card_manager_reference=$"../CardManager"
	deck_reference=$"../Deck"

func _input(event):
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		if event.pressed:
			emit_signal("left_mouse_button_clicked")
			#spostamento_deck(n)
		else:
			emit_signal("left_mouse_button_released")
			pass

func spostamento_deck(n):
	var space_state=get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position=get_global_mouse_position()
	parameters.collide_with_areas=true
	var result=space_state.intersect_point(parameters)
	if result.size()>0:
		#controllo su z-index di hover
		var res_collision_mask=result[0].collider.collision_mask
		if res_collision_mask==COLLISION_MASK_CARD:
			var carta_sposta=result[0].collider.get_parent()
			if carta_sposta:
				card_manager_reference.inizio_spostamento(carta_sposta)
		elif res_collision_mask == COLLISION_MASK_DECK:
			deck_reference.disegna_carta(n)
			
	else:
		return null
