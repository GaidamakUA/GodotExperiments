extends KinematicBody2D
class_name OneByOneMob

export var attack := 1
var player_number: int setget _set_player_number
var velocity: Vector2
var enemy_hp: Hp
var collision_bit_enemy
var collision_bit_enemy_base
var collision_bit_ally
var collision_bit_ally_base

func _set_player_number(player_number: int):
	print("player number inited")
	if player_number == 0:
		velocity = Vector2(1, 0)
		collision_bit_enemy = 1
		collision_bit_enemy_base = 3
		collision_bit_ally = 0
		collision_bit_ally_base = 2
		collision_layer = 1
		collision_mask = collision_mask | 8
	else:
		velocity = Vector2(-1, 0)
		$Sprite.flip_h = true
		collision_bit_enemy = 0
		collision_bit_enemy_base = 2
		collision_bit_ally = 1
		collision_bit_ally_base = 3
		collision_layer = 2
		collision_mask = collision_mask | 4

func _physics_process(delta):
	var collision_info := move_and_collide(velocity)
	if collision_info:
		var collider := collision_info.collider as PhysicsBody2D
		var colliding_enemy = collider.get_collision_layer_bit(collision_bit_enemy)
		var colliding_enemy_base = collider.get_collision_layer_bit(collision_bit_enemy_base)
		var colliding_ally = collider.get_collision_layer_bit(collision_bit_ally)
		if colliding_enemy || colliding_enemy_base:
			$Sprite.modulate = Color.red
			if not $AnimationPlayer.current_animation == "Attack":
				$AnimationPlayer.play("Attack")
				enemy_hp = collider.find_node("Hp")
		elif colliding_ally:
			$Sprite.modulate = Color.green
			print("colliding_ally")
			if $AnimationPlayer.is_playing():
				$AnimationPlayer.stop()
				$Sprite.frame = 0
	else:
		$Sprite.modulate = Color.white
		if not $AnimationPlayer.current_animation == "Running":
			$AnimationPlayer.play("Running")

func _attack_enemy():
	enemy_hp.damage(attack)

func _on_Hp_died():
	queue_free()