class_name Monster
extends CharacterBody2D

@export var movement_speed: float
@export var search_radius: float = 500

var _player: Player
var _sprite_2d: Sprite2D
var _health: HealthComponent
var _health_label: HealthLabel

func _ready() -> void:
	_player = get_tree().current_scene.find_child("Player")
	_sprite_2d = find_child("Sprite2D")
	_health = find_child("HealthComponent")

	_health.on_die.connect(
		Callable(
			self,
			"_handle_on_die"
		))
	_health.on_damage.connect(Callable(
		self,
		"_handle_on_damage"
	))

	_health_label = find_child("HealthLabel")

func _physics_process(_delta: float) -> void:
	var player_pos = _player.position
	var target_pos = (player_pos - position).normalized()

	if position.distance_to(player_pos) < search_radius:
		move_and_collide(target_pos*movement_speed*_delta)

	if target_pos.x < 0:
		_sprite_2d.flip_h = true
	else:
		_sprite_2d.flip_h = false

func _handle_on_die():
	queue_free()

func _handle_on_damage(remaining:int):
	_health_label.show_remaining_health(remaining)