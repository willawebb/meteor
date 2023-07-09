extends Node

@export var asteroid_scene: PackedScene

@export var ship_scene: PackedScene

func freeze_frame(duration, timescale):
	
	Engine.time_scale = timescale
	print(Engine.time_scale)
	await(get_tree().create_timer(duration * timescale).timeout)
	Engine.time_scale = 1.0

func _process(delta):
	
	if Input.is_action_just_pressed("select"):
		var asteroid = asteroid_scene.instantiate()
		
		asteroid.position = get_viewport().get_mouse_position()
		
		var direction = randf_range(-PI / 4, PI / 4)
		
		var velocity = Vector2(randf_range(150.0, 600.0), 0.0)
		
		asteroid.linear_velocity = velocity.rotated(direction)
		
		add_child(asteroid)
		
	if Input.is_action_just_pressed("button_1"):
		var ship = ship_scene.instantiate()
		
		ship.position = get_viewport().get_mouse_position()
		
		var direction = randf_range(-PI / 4, PI / 4)
		
		ship.connect("enemy_hit", _on_the_ship_from_asteroids_enemy_hit)
		
		add_child(ship)
		
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()


func _on_the_ship_from_asteroids_enemy_hit():
	freeze_frame(0.5, 0.05)
