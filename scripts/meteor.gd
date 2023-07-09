extends RigidBody2D

@export var accel = 50

@export var max_speed = 600

var screen_size

var speed

var hp = 10

signal dead(meteor_pos)

func _ready():
	screen_size = get_viewport_rect().size
	gravity_scale = 0.0
	linear_damp = 1.0

func get_input():
	speed = Vector2.ZERO
	
	if Input.is_action_pressed("move_down"):
		speed.y += accel
	if Input.is_action_pressed("move_up"):
		speed.y -= accel
	if Input.is_action_pressed("move_right"):
		speed.x += accel
	if Input.is_action_pressed("move_left"):
		speed.x -= accel
		
func take_damage(dmg):
	hp -= dmg
	
	if hp <= 0:
		hide()
		dead.emit(position)
		$CollisionPolygon2D.set_deferred("disabled", true)
		queue_free()
	else:
		$DamageTaken.play()

func _integrate_forces(state):
	get_input()
	apply_central_impulse(speed)
	
	
	#Wrapping functionality. Cannot simply change position as that breaks
	state.transform.origin.x = wrapf(state.transform.origin.x, 0, screen_size.x)
	state.transform.origin.y = wrapf(state.transform.origin.y, 0, screen_size.y)
	

