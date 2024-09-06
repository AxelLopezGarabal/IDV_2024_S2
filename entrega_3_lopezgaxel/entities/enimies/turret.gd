extends Sprite2D

class_name Turret
@export var projectile:PackedScene
var projectile_container:Node
@onready var fire_pos:Marker2D = $Position
var target: Node2D

func initialize(container, turret_pos, projectile_container):
	container.add_child(self)
	global_position = turret_pos
	self.projectile_container = projectile_container

func set_values(new_player, container):
	self.player = new_player
	self.projectile_container = container

func _on_timer_timeout():
	fire()

func fire():
	var new_bullet:Projectile = projectile.instantiate()
	new_bullet.initialize(
		projectile_container, 
		fire_pos.global_position, 
		fire_pos.global_position.direction_to(target.global_position))
	new_bullet.delete_req.connect(_on_projectile_delete_req)
	
func _on_projectile_delete_req(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if target == null:
		target = body
		$Timer.start()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
		$Timer.stop()
