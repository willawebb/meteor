extends Node2D

signal bullet_hit

var speed = 50

# Called when the node enters the scene tree for the first time.
func _process(delta):
	position += transform.x * speed * delta
	
func _on_kill_timer_timeout():
	queue_free() # Replace with function body.

func _on_body_entered(body):
	hide()
	body.take_damage(1)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
