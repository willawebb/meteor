extends Node

@export var asteroid_scene: PackedScene

func _process(delta):
	
	if Input.is_action_just_pressed("select"):
		var asteroid = asteroid_scene.instantiate()
		
		asteroid.position = get_viewport().get_mouse_position()
		
		var direction = randf_range(-PI / 4, PI / 4)
		
		var velocity = Vector2(randf_range(150.0, 600.0), 0.0)
		
		asteroid.linear_velocity = velocity.rotated(direction)
		
		add_child(asteroid)
		
		
		
