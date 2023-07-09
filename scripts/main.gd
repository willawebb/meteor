extends Node

@export var asteroid_scene: PackedScene

@export var ship_scene: PackedScene

@export var explosion_scene: PackedScene

@export var meteor_scene: PackedScene

var score = 0

func _ready():
	$StartUp.play()
	

func game_over():
	$StartMessage.text = "How embarrassing."
	$StartMessage.show()
	await(get_tree().create_timer(3.0).timeout)
	$StartMessage.text = "Spaceships_"
	$SubTitle.show()
	$MadeBy.show()
	
func new_game():
	score = 0
	get_tree().call_group("meteor", "queue_free")
	get_tree().call_group("asteroids", "queue_free")
	get_tree().call_group("ships", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	$StartMessage.hide()
	$SubTitle.hide()
	$MadeBy.hide()
	
	var meteor = meteor_scene.instantiate()
	
	meteor.position = $StartPosition.position
	
	meteor.connect("dead", game_over)
	
	add_child(meteor)
	
	#The fucking game loop.
	
	
	

func freeze_frame(duration, timescale):
	
	Engine.time_scale = timescale
	await(get_tree().create_timer(duration * timescale).timeout)
	Engine.time_scale = 1.0

func _process(delta):
	
	if Input.is_action_just_pressed("button_2"):
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
		
	if Input.is_action_just_pressed("select"):
		new_game()
		
	if Input.is_action_just_pressed("escape"):
		$ItsJoever.play()
		await(get_tree().create_timer(0.5).timeout)
		get_tree().quit()


func _on_the_ship_from_asteroids_enemy_hit(ship_pos):
	$ShipHitSounds.play()
	
	#summon particles and ship rubble
	var particles = explosion_scene.instantiate()
	
	particles.position = ship_pos
	
	particles.emitting = true
	
	add_child(particles)
	
	#Shader changes
	var old_brightness = $VHS.material.get_shader_parameter("brightness")
	var old_aberration = $VHS.material.get_shader_parameter("aberration")
	
	$VHS.material.set_shader_parameter("brightness", old_brightness+10)
	$VHS.material.set_shader_parameter("aberration", 0.05)
	
	#freeze frame
	await(freeze_frame(0.6, 0.05))
	
	#reverting shader changes
	$VHS.material.set_shader_parameter("brightness", old_brightness)
	$VHS.material.set_shader_parameter("aberration", old_aberration)
	
