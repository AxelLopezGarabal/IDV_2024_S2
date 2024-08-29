extends Sprite2D
@export var speed:int = 600 # How fast the player will move (pixels/sec).
var cannon:Sprite2D
var screen_size # Size of the game window.
var bullet_container:Node

func _ready():
	cannon = $Cannon

func _process(delta):
	position.x += (int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))) * speed * delta
	var mouse_pos:Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_pos)
	if Input.is_action_just_pressed("Fire"):
		cannon.fire()

func set_bullet_container(container:Node):
	cannon.bullet_container = container
	bullet_container = container
