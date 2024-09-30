extends RigidBody2D

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	freeze = false

@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	timer.start()
