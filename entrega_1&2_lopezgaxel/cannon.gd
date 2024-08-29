extends Sprite2D
@export var projectile:PackedScene
var firePosition:Marker2D
var bullet_container:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	firePosition = $FirePosition

func fire():
	var new_bullet:Projectile = projectile.instantiate()
	new_bullet.set_starting_values(firePosition.global_position, (firePosition.global_position - global_position).normalized())
	bullet_container.add_child(new_bullet)
	new_bullet.delete_req.connect(_on_projectile_delete_req)
	
func _on_projectile_delete_req(projectile):
	bullet_container.remove_child(projectile)
	projectile.queue_free()
