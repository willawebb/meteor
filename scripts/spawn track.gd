extends Path2D

@export var thing_to_spawn: PackedScene

@export_range(0.5, 60, 0.5) var spawn_rate = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnRate.start(spawn_rate) # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_spawn_rate_timeout():
	var thing = thing_to_spawn.instantiate()
	
	var spawn_location = $SpawnLocation
	spawn_location.progress_ratio = randf()
	
	# TODO: check if the curve is anticlockwise add a half turn
	var direction = spawn_location.rotation + PI / 2
	
	thing.position = spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	thing.rotation = direction
	
	var velocity = Vector2(randf_range(25.0, 100.0), 0.0)
	thing.linear_velocity = velocity.rotated(direction)
	
	add_child(thing)
