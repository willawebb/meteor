extends RigidBody2D

@export var accel = 50

@export var max_speed = 600

var screen_size

var speed

signal collision(id, new_velocity)

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

func _physics_process(delta):
	get_input()
	apply_central_impulse(speed)
	
	
	#Wrapping functionality.
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
