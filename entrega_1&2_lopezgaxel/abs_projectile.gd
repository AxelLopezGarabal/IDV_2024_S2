extends Sprite2D

class_name Projectile
var direction:Vector2
@export var speed = 500

func set_starting_values(star_position:Vector2, dir:Vector2):
	global_position = star_position
	self.direction = dir

func _physics_process(delta):
	position += direction * speed * delta
