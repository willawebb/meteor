extends Path2D

@export var thing_to_spawn: PackedScene
@export_range(0.5, 60, 0.5) var spawn_rate = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnPoint.thing_to_spawn = thing_to_spawn
	$SpawnPoint.track_to_follow = $PathFollow2D
	$SpawnPoint.spawn_rate = spawn_rate
	$SpawnPoint.starting_point = position
	$SpawnPoint.start()
