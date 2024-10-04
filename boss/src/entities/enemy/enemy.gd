extends CharacterBody2D

class_name enemy
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var flag_of_area:int = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()


func _on_weak_point_body_entered(body: Node2D) -> void:
	if flag_of_area == 0: 
		flag_of_area = 1
		if body is player: 
			queue_free()
			print(body, "yo deberia morir")
	flag_of_area = 0


func _on_area_body_entered(body: Node2D) -> void:
	if flag_of_area == 0: 
		flag_of_area = 1
		if body is player: 
			body.queue_free()
			get_tree().reload_current_scene()
			print(body, "el deberia morir")
