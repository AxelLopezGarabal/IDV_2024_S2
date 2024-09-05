extends Sprite2D
class_name Projectile

signal delete_req(projectile)
var direction:Vector2
@export var speed = 500

func initialize(container, spawn_position:Vector2, direction:Vector2):
	container.add_child(self)
	self.direction = direction
	global_position = spawn_position
	$Timer.start()

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_timer_timeout():
	emit_signal("delete_req", self)
