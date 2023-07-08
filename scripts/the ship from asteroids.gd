extends CharacterBody2D


const speed = 300.0
const angular_speed = PI

func _process(delta): # _physics_process
	# Speen
	rotation += angular_speed * delta

	var v = Vector2.UP.rotated(rotation) * speed

	position += v * delta

	# velocity.x = move_toward(velocity.x, 0, speed)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # Replace with function body.
