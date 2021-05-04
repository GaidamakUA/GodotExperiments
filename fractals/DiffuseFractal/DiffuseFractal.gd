extends Control

onready var particleScene := preload("res://DiffuseFractal/Particle.tscn")

export var particles_number := 10
export var particle_speed := 10
onready var _particle_speed := Vector2(0, particle_speed)

func _ready():
	for i in range(particles_number):
		_add_new_particle()

func _add_new_particle():
	var particle: Particle = particleScene.instance()
	particle.connect("settled", self, "_on_particle_settled")
	particle.speed = _particle_speed.rotated(randf() * 2 * PI)
	var random_x = randi() % int(rect_size.x)
	var random_y = randi() % int(rect_size.y)
	particle.position = Vector2(random_x, random_y)
	add_child(particle)

func _on_particle_settled():
	print("settled")
	_add_new_particle()
