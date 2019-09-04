extends KinematicBody2D

var velocity := Vector2(2, 0)

func _ready():
	pass

func _physics_process(delta):
	move_and_collide(velocity)