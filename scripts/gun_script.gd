extends Node2D

@export var sprite_2d: Sprite2D
@export var bullet_scene: PackedScene
@export var fire_speed: float
@export var damage: int
@export var sound_effects: AudioStreamPlayer2D

var _player_animated_sprite_2d: AnimatedSprite2D
var _shooting_position: Marker2D
var _spawner: Spawner = Spawner.new()
var _animation_player: AnimationPlayer

func _ready() -> void:
	add_child(_spawner)
	_player_animated_sprite_2d = get_node_or_null("../AnimatedSprite2D")
	_shooting_position = find_child("ShootingPosition")
	_animation_player = find_child("AnimationPlayer")

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())

	if Input.is_action_pressed("ui_fire"):
		_play_shooting_animation()

	if global_rotation_degrees > -90 && global_rotation_degrees < 90:
		sprite_2d.flip_v = false
		_player_animated_sprite_2d.flip_h = false
	else:
		sprite_2d.flip_v = true
		_player_animated_sprite_2d.flip_h = true

func _play_shooting_animation():
	_animation_player.play("shooting")

func shoot_bullet():
	var bullet: Bullet = _spawner.spawn(bullet_scene, _shooting_position.global_position)
	bullet.rotate(global_rotation)
	bullet.speed = Vector2(fire_speed, 0).rotated(global_rotation)
	bullet.damage_to = "enemy"
	bullet.damage_value = damage

	if sound_effects != null:
		sound_effects.play()
