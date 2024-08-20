class_name GameManager
extends Node

@export var enemy_scene: PackedScene
@export var rune_scene: PackedScene
@export var num_of_enemies: int
@export var num_of_runes: int
@export var timer_label: Label
@export var lose_control: Control
@export var win_control: Control
@export var play_time: float =  45

@onready var topLeftMargin: Marker2D = %TopLeftMargin
@onready var bottomRightMargin: Marker2D = %BottomRightMargin
@onready var player: Player = %Player

var _spawner: Spawner = Spawner.new()
var _timer: Timer = Timer.new()

func _ready() -> void:
	Engine.time_scale = 1
	lose_control.visible = false
	win_control.visible = false
	
	add_child(_spawner)
	add_child(_timer)

	for i in range(num_of_enemies):
		_summon_enemy()

	for i in range(num_of_runes):
		_summon_rune()

	_timer.wait_time = play_time
	_timer.start()
	_timer.timeout.connect(
		Callable(
			self,
			"_handle_timer_timeout"
		))
	
func _process(_delta: float) -> void:
	timer_label.text = "%4.2f" % _timer.time_left

	if player.is_dead:
		Engine.time_scale = 0
		lose_control.visible = true

func _summon_enemy():
	var posx: float = randf_range(topLeftMargin.global_position.x, bottomRightMargin.global_position.x)
	var posy: float = randf_range(topLeftMargin.global_position.y, bottomRightMargin.global_position.y)

	_spawner.spawn(enemy_scene, Vector2(posx, posy))

func _summon_rune():
	var posx: float = randf_range(topLeftMargin.global_position.x, bottomRightMargin.global_position.x)
	var posy: float = randf_range(topLeftMargin.global_position.y, bottomRightMargin.global_position.y)

	var rune:RuneMultiply = _spawner.spawn(rune_scene, Vector2(posx, posy))
	rune.multiply = [6,18,54].pick_random()

func _handle_timer_timeout():
	Engine.time_scale = 0
	win_control.visible = true
