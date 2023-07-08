extends RigidBody2D

signal enemy_hit

signal collision(id, new_velocity)

@export var accel = 20

@export var speedlimit = 300

const wide_spin = 300

const little_spin = PI

func _process(delta): # _physics_process
	# Speen
	rotation += little_spin * delta

	var v = Vector2.UP.rotated(rotation) * wide_spin

	position += v * delta

	# velocity.x = move_toward(velocity.x, 0, speed)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # Replace with function body.

func _on_body_entered(_body):
	hide()
	enemy_hit.emit() # so we can do whatever we want knowing we've hit them
	$CollisionPolygon2D.set_deferred("disabled", true)
	
	pass # create an explosion effect?
