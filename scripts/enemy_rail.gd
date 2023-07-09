extends Path2D

@export var thing_to_spawn: PackedScene
@export var spawn_rate: Array[float] = [5.0]

signal stop_rail

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("rails")
	$SpawnPoint.thing_to_spawn = thing_to_spawn
	$SpawnPoint.track_to_follow = $PathFollow2D
	$SpawnPoint.spawn_rate = spawn_rate
	$SpawnPoint.starting_point = position
	start()

func start():
	$SpawnPoint.start()

func stop():
	$SpawnPoint.stop()

func _on_stop_rail():
	stop()
