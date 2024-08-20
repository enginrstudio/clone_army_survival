class_name PlayerCloneController
extends Node2D

@export var clone: PackedScene
@export var clone_spacing: Vector2

var _clones = []
var _spacing_from_center: Vector2
var _multiplier: int = 0
var _angle: int = 0
var _angle_adder: int = 60
var _health: HealthComponent
var _spawner: Spawner = Spawner.new()


func _ready() -> void:
	add_child(_spawner)
	_health = get_node("../HealthComponent")
	_health.on_multiply_rune.connect(
		Callable(
			self,
			"_handle_multiply_rune"
		))

func _process(_delta: float) -> void:
	pass

func _add_clone():
	# if _clones.size() == 42:
	# 	return

	_spacing_from_center = clone_spacing + clone_spacing * (_multiplier)
	
	# var _clone:PlayerClone = clone.instantiate()
	# _clone.position = (position + _spacing_from_center).rotated(deg_to_rad(_angle))
	# add_child(_clone)

	var _clone: PlayerClone = _spawner.spawn(
		clone,
		(position + _spacing_from_center).rotated(deg_to_rad(_angle)),
		self
	)

	_clones.append(_clone)

	if _clones.size() in [6,18]:
		_multiplier += 1
		_angle_adder = _angle_adder / 2
		_angle = 0

	_angle -= _angle_adder

func _generate_clone(num: int):
	if _clones.size() > 0:
		return

	for i in range(num):
		_add_clone()

	_angle = 0
	_angle_adder = 60
	_multiplier = 0

func set_clone_run():
	if _clones.size() == 0:
		return
	for c: PlayerClone in _clones:
		if c != null:
			c.set_state_run()

func set_clone_idle():
	if _clones.size() == 0:
		return
	for c: PlayerClone in _clones:
		if c != null:
			c.set_state_idle()

func _handle_multiply_rune(mul: int):
	_generate_clone(mul)