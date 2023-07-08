extends RigidBody2D

signal enemy_hit

@export var accel = 20

@export var speedlimit = 300

@export var bullet_speed = 100.0

@export var spawn_points = 1

@export var spawn_distance = 60 #distance from centre of gun that rotator points are at.

@export var rotate_speed = 0.0 #degrees per second.

func _ready():
	$Gun.set_bullet_speed(bullet_speed)
	$Gun.set_spawn_points(spawn_points)
	$Gun.set_spawn_distance(spawn_distance)
	$Gun.set_rotate_speed(rotate_speed)
	print("Does this do anything?")

func _integrate_forces(state):
	pass
	# velocity.x = move_toward(velocity.x, 0, speed)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(_body):
	hide()
	
	$CollisionPolygon2D.set_deferred("disabled", true)
	queue_free()
	
	pass # create an explosion effect?
	
