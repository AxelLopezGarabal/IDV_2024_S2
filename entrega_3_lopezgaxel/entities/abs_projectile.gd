extends Sprite2D
class_name Projectile

signal delete_req(projectile)
var direction:Vector2
@export var speed = 500

func set_starting_values(star_position:Vector2, dir:Vector2):
	global_position = star_position
	self.direction = dir
	$Timer.autostart = true #tiene que estar seteado en true

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_timer_timeout():
	emit_signal("delete_req", self)
