extends CharacterBody2D
class_name Player
@export var ACCELERATION:float = 20.0
@export var H_SPEED_LIMIT:float = 600.0
@export var J_SPEED:float = -500.0
@export var G_Force:float = 5.0
@export var FRICTION_WEIGHT:float = 0.1

var up:Vector2 = Vector2.UP
var vel:Vector2 = Vector2.ZERO
var cannon:Sprite2D
var screen_size # Size of the game window.
var bullet_container:Node

func _ready():
	cannon = $Cannon

func _process(delta):
	var mov_dir:int = (int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left")))
	
	if mov_dir != 0:
		velocity.x = clamp(velocity.x + (mov_dir * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	if Input.is_action_just_pressed("jump"):
		velocity.y = J_SPEED
	
	velocity.y += G_Force
	move_and_slide()#no requiere parametro
	#position += velocity * delta
	
	var mouse_pos:Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_pos)
	if Input.is_action_just_pressed("Fire"):
		cannon.fire()

func set_bullet_container(container:Node):
	cannon.bullet_container = container
	bullet_container = container
