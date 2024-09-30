extends AbstractState


# Al entrar se activa primero la animación "walk"
func enter() -> void:
	character._play_animation("walk")


func handle_input(event:InputEvent) -> void:
	if  event.is_action_pressed("strong_action") && character._is_on_floor():
		emit_signal("finished", "hijump")
	if event.is_action_pressed("jump") && character._is_on_floor():
		emit_signal("finished", "jump")
	if  event.is_action_pressed("sprint") && character._is_on_floor():
		emit_signal("finished", "sprint")

# En esta función vamos a manejar las acciones apropiadas para este estado
func update(delta: float) -> void:
	#if(Input.is_action_pressed("sprint")): character._handle_sprint_input()
	#else: 
	character._handle_move_input()
	character._apply_movement(delta)
	if character.move_direction == 0:
		emit_signal("finished", "idle")
	else:
		if character.is_on_floor():
			character._play_animation("walk")
		else:
			if character.velocity.y > 0:
				character._play_animation("fall")
			else:
				character._play_animation("jump")


# En este callback manejamos, por el momento, solo los impactos
func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			character._handle_hit(value)
			if character.dead:
				emit_signal("finished", "dead")
