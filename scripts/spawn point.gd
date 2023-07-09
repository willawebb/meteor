extends Node2D

@export var thing_to_spawn: PackedScene
@export var track_to_follow: PathFollow2D
@export var starting_point: Vector2
@export var spawn_rate: Array[float] = [5.0]
var spawn_index = 0

func start():
	$SpawnRate.start(spawn_rate[spawn_index])
	

func stop():
	$SpawnRate.stop()

func _on_spawn_rate_timeout():
	if len(spawn_rate) > 1:
		stop()
		spawn_index += 1
		spawn_index %= len(spawn_rate)
		if spawn_rate[spawn_index] <= 0.0:
			return
		start()
	var thing = thing_to_spawn.instantiate()
	thing.set_track(track_to_follow, starting_point)
	add_child(thing)
