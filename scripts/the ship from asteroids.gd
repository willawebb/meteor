extends RigidBody2D

signal enemy_hit

@export var accel = 20

@export var speedlimit = 300

func _physics_process(delta): # 
	pass
	# velocity.x = move_toward(velocity.x, 0, speed)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(_body):
	print("collision")
	hide()
	enemy_hit.emit() # so we can do whatever we want knowing we've hit them
	$CollisionPolygon2D.set_deferred("disabled", true)
	queue_free()
	
	pass # create an explosion effect?
	
