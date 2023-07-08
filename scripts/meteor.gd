extends CharacterBody2D

@export var accel = 50

@export var max_speed = 600

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	if Input.is_action_pressed("move_down"):
		velocity.y += accel
	if Input.is_action_pressed("move_up"):
		velocity.y -= accel
	if Input.is_action_pressed("move_right"):
		velocity.x += accel
	if Input.is_action_pressed("move_left"):
		velocity.x -= accel
		
	if not Input.is_anything_pressed():
		velocity.x = lerp(velocity.x, 0.0, 0.1)
		velocity.y = lerp(velocity.y, 0.0, 0.1)

func _physics_process(delta):
	get_input()
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	move_and_slide()
	
	#Wrapping functionality.
	position.x = wrapf(position.x, 0, screen_size.x)
	position.y = wrapf(position.y, 0, screen_size.y)
