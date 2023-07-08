extends Node2D

@export var bullet_scene: PackedScene

@export var bullet_speed = 100.0

@export var spawn_points = 1 #how many guns are firing.

@export var spawn_distance = 20 #distance from centre of gun that rotator points are at.

@export var rotate_speed = 10.0 #degrees per second.

func _ready():
	var step = 2 * PI / spawn_points
	
	for i in range(spawn_points):
		var spawn_point = Node2D.new()
		var pos = Vector2(spawn_distance, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		$Rotator.add_child(spawn_point)
		
	$FireRate.start()
	
func _process(delta):
	var new_rotation = $Rotator.rotation_degrees + rotate_speed * delta
	$Rotator.rotation_degrees = fmod(new_rotation, 360)

func _on_fire_rate_timeout():
	for s in $Rotator.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation
