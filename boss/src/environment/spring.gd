extends StaticBody2D

@export var force_x:float = 0.0
@export var force_y:float = 3.0
@export var direction:int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		body.sendFlying(force_x, force_y)
