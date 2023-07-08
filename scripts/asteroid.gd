extends RigidBody2D

var hp = 10

func take_damage(dmg):
	hp -= dmg
	print("One of the asteroids took {str} damage!".format({"str": hp}))
