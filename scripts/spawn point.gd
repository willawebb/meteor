extends Node2D

@export var thing_to_spawn: PackedScene
@export var track_to_follow: PathFollow2D
@export_range(0.5, 60, 0.5) var spawn_rate = 5.0

func start():
	$SpawnRate.start(spawn_rate)

func _on_spawn_rate_timeout():
	var thing = thing_to_spawn.instantiate()
	thing.set_track(track_to_follow)
	add_child(thing)
