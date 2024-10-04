extends CharacterBody2D

class_name player

signal hit(amount)

@export  var ACCELERATION: float = 20.0
@export  var H_SPEED_LIMIT: float = 300.0
@export  var FRICTION_WEIGHT: float = 0.1
@export  var JUMP_VELOCITY: int = 350
@export  var jump_speed: int = 375
@export var SPEED = 150.0

const FLOOR_NORMAL: Vector2 = Vector2.UP  # Igual a Vector2(0, -1)
const SNAP_DIRECTION: Vector2 = Vector2.DOWN
const SNAP_LENGTH: float = 32.0
const SLOPE_THRESHOLD: float = deg_to_rad(46)

var snap_vector: Vector2 = SNAP_DIRECTION * SNAP_LENGTH
var is_dead: bool = false
var move_direction: int = 0
var stop_on_slope: bool = true

@onready var pivot: Node2D = $pivot
@onready var floor_raycasts: Array = $FloorRaycasts.get_children()


func _ready() -> void:
	_initialize()

func _initialize() -> void:
	pass

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	pass
	# Add the gravity.
	#if not _is_on_floor():
	#	velocity += get_gravity() * delta
	#_apply_movement(delta)
	# Handle jump.
	#if Input.is_action_just_pressed("jump") and _is_on_floor():
	#	velocity.y -= JUMP_VELOCITY
	#_handle_move_input()
	#_handle_deacceleration()

func _is_on_floor() -> bool:
	var is_colliding: bool = is_on_floor()
	for raycast in floor_raycasts:
		## Al tener deshabilitados los raycasts por default
		## ya que queremos que solamente se procesen en esta
		## función, debemos forzar una actualización
		raycast.force_raycast_update()
		is_colliding = is_colliding || raycast.is_colliding()
	return is_colliding

func _handle_move_input() -> void:
	move_direction = int(Input.is_action_pressed("mov_right")) - int(Input.is_action_pressed("mov_left"))
	if move_direction != 0:
		velocity.x = clamp(velocity.x + (move_direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
		pivot.scale.x = 1 - 2 * float(move_direction < 0)
	move_and_slide()

func _handle_sprint_input() -> void:
	move_direction = int(Input.is_action_pressed("mov_right")) - int(Input.is_action_pressed("mov_left"))
	if move_direction != 0:
		velocity.x = clamp(velocity.x + (move_direction * ACCELERATION*4), -H_SPEED_LIMIT*4, H_SPEED_LIMIT*4)
		pivot.scale.x = 1 - 2 * float(move_direction < 0)
	move_and_slide()

func _handle_deacceleration() -> void:
	velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0

func _apply_movement(value:float) -> void:
	velocity.y += get_gravity().y * value
	move_and_slide()
	#velocity = move_and_slide_with_snap(velocity, snap_vector, FLOOR_NORMAL, stop_on_slope, 4, SLOPE_THRESHOLD)
	if _is_on_floor() && snap_vector == Vector2.ZERO:
		snap_vector = SNAP_DIRECTION * SNAP_LENGTH

func _handle_jump() -> void:
	snap_vector = Vector2.ZERO
	velocity.y -= jump_speed

func _handle_hi_jump() -> void:
	snap_vector = Vector2.ZERO
	velocity.y -= jump_speed * 1.2

func _remove() -> void:
	set_physics_process(false)
	collision_layer = 0

func notify_hit(amount: int = 1) -> void:
	emit_signal("hit", amount)

@warning_ignore("unused_parameter")
func _play_animation(name: String) -> void:
	pass

func sendFlying(force_x:float, force_y:float) -> void:
	velocity.x = velocity.x + (SPEED) * force_x
	velocity.y -= JUMP_VELOCITY * force_y
