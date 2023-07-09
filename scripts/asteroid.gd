extends RigidBody2D

var hp = 10

func _ready():
	add_to_group("asteroids")

func take_damage(dmg):
	hp -= dmg
	print("One of the asteroids took {str} damage!".format({"str": hp}))


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
