extends CharacterBody2D


const speed = 300.0
const angular_speed = PI

func _process(delta): # _physics_process
	# Speen
	rotation += angular_speed * delta

	var velocity = Vector2.UP.rotated(rotation) * speed

	position += velocity * delta

	# velocity.x = move_toward(velocity.x, 0, speed)
