extends Node2D

@export var speed = 50

# Called when the node enters the scene tree for the first time.
func _process(delta):
	position += transform.x * speed * delta
	
func _on_kill_timer_timeout():
	queue_free() # Replace with function body.

func change_speed(new_speed):
	speed = new_speed
