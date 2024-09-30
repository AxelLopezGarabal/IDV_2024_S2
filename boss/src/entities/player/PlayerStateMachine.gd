extends AbstractStateMachine

func notify_hit(amount: int) -> void:
	current_state.handle_event("hit", amount)
