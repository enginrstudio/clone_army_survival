class_name MonsterShootingComponent
extends Node2D

@export var bullet_scene: PackedScene
@export var damage : int
@export var bullet_speed: float

var _timer: Timer = Timer.new()
var _spawner: Spawner = Spawner.new()
var _shooting_pos: Marker2D
var _player: Player

func _ready() -> void:
	_player = get_tree().current_scene.find_child("Player")
	_shooting_pos = find_child("ShootingPosition")
	add_child(_spawner)
	add_child(_timer)
	_timer.wait_time = [1].pick_random()
	_timer.timeout.connect(Callable(
		self,
		"_handle_timer_timeout"
	))
	_timer.start()

func _handle_timer_timeout():
	var bullet: Bullet = _spawner.spawn(
		bullet_scene,
		_shooting_pos.global_position
	)
	bullet.damage_to = "player"
	bullet.damage_value = damage

	var player_pos = _player.global_position
	var target_pos = (player_pos - global_position).normalized()
	bullet.speed = target_pos * bullet_speed
	
