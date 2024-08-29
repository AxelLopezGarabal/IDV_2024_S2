extends Sprite2D
@export var projectile:PackedScene
var player
var projectile_container:Node
@onready var fire_pos:Marker2D = $Position

func set_values(new_player, container):
	self.player = new_player
	self.projectile_container = container
	$Timer.start()

func _on_timer_timeout():
	fire()

func fire():
	var new_bullet:Projectile = projectile.instantiate()
	new_bullet.set_starting_values(fire_pos.global_position, (fire_pos.global_position - global_position).normalized())
	projectile_container.add_child(new_bullet)
	new_bullet.delete_req.connect(_on_projectile_delete_req)
	
func _on_projectile_delete_req(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
