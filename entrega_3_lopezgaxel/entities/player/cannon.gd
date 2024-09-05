extends Sprite2D
@export var projectile:PackedScene
var firePosition:Marker2D
var bullet_container:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	firePosition = $FirePosition

func fire():
	var new_bullet:Projectile = projectile.instantiate()
	new_bullet.initialize(
		bullet_container, 
		firePosition.global_position, 
		global_position.direction_to(firePosition.global_position)
	)
	new_bullet.delete_req.connect(_on_projectile_delete_req)
	
func _on_projectile_delete_req(projectile):
	bullet_container.remove_child(projectile)
	projectile.queue_free()
