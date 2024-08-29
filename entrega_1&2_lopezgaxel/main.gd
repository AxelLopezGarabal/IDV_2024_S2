extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.set_bullet_container(self)
