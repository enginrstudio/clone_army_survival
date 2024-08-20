class_name Player
extends CharacterBody2D

var _animated_sprite_2d: AnimatedSprite2D
var _health: HealthComponent
var _health_label: HealthLabel

var is_dead: bool = false

func _ready() -> void:
	_animated_sprite_2d = find_child("AnimatedSprite2D")
	
	_health = find_child("HealthComponent")
	_health.on_damage.connect(Callable(
		self,
		"_handle_on_damage"
	))
	_health.on_die.connect(Callable(
		self,
		"_handle_on_die"
	))

	_health_label = find_child("HealthLabel")

func flip(val:bool):
	_animated_sprite_2d.flip_h = val

func _handle_on_damage(remaining:int):
	_health_label.show_remaining_health(remaining)

func _handle_on_die():
	is_dead = true