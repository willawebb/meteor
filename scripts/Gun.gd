extends Node2D

@export var bullet_scene: PackedScene

@export_range(1, 1000) var bullet_speed = 100

@export_range(1, 64) var spawn_points = 1 # how many guns are firing.

@export_range(1, 1000) var spawn_distance = 20 # distance from centre of gun that rotator points are at.

@export_range(0, 360, 0.1) var rotate_speed: float = 10.0 # degrees per second.

@export var fire_rate: Array[float] = [2.0]
var fire_index = 0

# Change these in the node inspector of the ship scene, don't make a new gun

func start():
	var step = 2 * PI / spawn_points
	
	for i in range(spawn_points):
		var spawn_point = Node2D.new()
		var pos = Vector2(spawn_distance, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		$Rotator.add_child(spawn_point)
	
	$FireRate.start(fire_rate[fire_index])

func _process(delta):
	var new_rotation = $Rotator.rotation_degrees + rotate_speed * delta
	$Rotator.rotation_degrees = fmod(new_rotation, 360)

func _on_fire_rate_timeout():
	if len(fire_rate) > 1:
		$FireRate.stop()
		fire_index += 1
		fire_index %= len(fire_rate)
		if fire_rate[fire_index] <= 0.0:
			return
		$FireRate.start(fire_rate[fire_index])
	for s in $Rotator.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
		bullet.speed = bullet_speed
