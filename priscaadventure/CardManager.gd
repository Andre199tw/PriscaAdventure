extends Node2D

const COLLISION_MASK_CARD=1
var carta_sposta
var dim_screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dim_screen=get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if carta_sposta:
		var pos_mouse= get_global_mouse_position()
		carta_sposta.position=Vector2(clamp(pos_mouse.x,0,dim_screen.x),clamp(pos_mouse.y,0,dim_screen.y))


#chiamata al click del mouse
func _input(event):
	if event is InputEventMouseButton and event.button_index==MOUSE_BUTTON_LEFT:
		if event.pressed:
			var carta=spostamento()
			if carta:
				carta_sposta=carta
		else:
			carta_sposta=null



func spostamento():
	var space_state=get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position=get_global_mouse_position()
	parameters.collide_with_areas=true
	parameters.collision_mask=COLLISION_MASK_CARD
	var result=space_state.intersect_point(parameters)
	if result.size()>0:
		return result[0].collider.get_parent()
	else:
		return null


func connetti_carta(carta):
	carta.connect("hovered", carta_hover)
	carta.connect("hovered_off", carta_non_hover)
	
func carta_hover(carta):
	effetto_hover(carta,true)
	
func carta_non_hover(carta):
	effetto_hover(carta,false)



func effetto_hover(carta, hovered):
	if hovered:
		carta.scale=Vector2(1.2,1.2)
		carta.z_index=2
	else:
		carta.scale=Vector2(1,1)
		carta.z_index=1
