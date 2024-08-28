extends Sprite2D
@export var speed:int = 600 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _process(delta):
	position.x += (int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))) * speed * delta
