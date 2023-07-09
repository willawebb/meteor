extends Node

@export var asteroid_scene: PackedScene

@export var ship_scene: PackedScene

@export var explosion_scene: PackedScene

@export var meteor_scene: PackedScene

var score = 0

var level = 0

func _ready():
	$StartUp.play()
	$ScoreBoard.hide()
	$SpawnTrack.stop()

	
func new_game():
	score = 0
	level = 0
	get_tree().call_group("meteor", "queue_free")
	get_tree().call_group("asteroids", "queue_free")
	get_tree().call_group("ships", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	$StartMessage.hide()
	$SubTitle.hide()
	$MadeBy.hide()
	$SpawnTrack.start()
	$ShuffleRailsTimer.start()
	
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
		
	if not get_tree().get_nodes_in_group("ships"):
		pass

func game_over(meteor_pos):
	var particles = explosion_scene.instantiate()
	
	particles.position = meteor_pos
	
	particles.process_material.color = Color(0.7, 0.2, 0.7)
	
	particles.emitting = true
	
	add_child(particles) 
	
	$GameOverSound.play()
	
	$VHS.material.set_shader_parameter("brightness", 12)
	$VHS.material.set_shader_parameter("aberration", 0.05)
	
	#freeze frame
	await(freeze_frame(1.0, 0.05))
	
	#reverting shader changes
	$VHS.material.set_shader_parameter("brightness", 1.4)
	$VHS.material.set_shader_parameter("aberration", 0.01)
	
	$SpawnTrack/SpawnRate.stop()
	if score < 25:
		$StartMessage.text = "How embarrassing."
	else:
		$StartMessage.text = "Starships\nWere Meant To\nFlyyyyy"
	$StartMessage.show()
	await(get_tree().create_timer(3.0).timeout)
	$StartMessage.text = "Spaceships_"
	$SubTitle.show()
	$MadeBy.show()

func _on_the_ship_from_asteroids_enemy_hit(ship_pos):
	score += 1
	$ScoreBoard.text = "[center]{score}[/center]".format({"score": score})
	$ScoreBoard.show()
	
	$ShipHitSounds.play()
	
	#summon particles and ship rubble
	var particles = explosion_scene.instantiate()
	
	particles.position = ship_pos
	
	particles.emitting = true
	
	add_child(particles)
	
	#Shader changes
	
	$VHS.material.set_shader_parameter("brightness", 12)
	$VHS.material.set_shader_parameter("aberration", 0.05)
	
	#freeze frame
	await(freeze_frame(0.6, 0.05))
	
	#reverting shader changes
	$VHS.material.set_shader_parameter("brightness", 1.4)
	$VHS.material.set_shader_parameter("aberration", 0.01)
	
	$ScoreBoard.hide()
	

func _on_shuffle_rails_timer_timeout():
	get_tree().call_group("rails", "stop")
	var rail_nodes = get_tree().get_nodes_in_group("rails")
	for i in range(3):
		rail_nodes[randi() % len(rail_nodes)].start()
