class_name Bullet
extends CharacterBody2D

var speed: Vector2 = Vector2.ZERO
var damage_to : String
var damage_value: int

var _timer: Timer = Timer.new()
var _damage_area: Area2D

func _ready() -> void:
	_damage_area = find_child("DamageArea")
	_damage_area.area_entered.connect(Callable(
		self,
		"_handle_area_entered"
	))
	
	add_child(_timer)

	_timer.wait_time = 5
	_timer.start()
	_timer.timeout.connect(
		Callable(
			self,
			"_handle_timer_timeout"
		)
	)

func _physics_process(_delta: float) -> void:
	move_and_collide(speed * _delta)

func _handle_timer_timeout():
	queue_free()

func _handle_area_entered(area):
	if damage_to == "":
		return
	
	if area.is_in_group(damage_to):
		if area is HealthComponent:
			var health : HealthComponent = area
			health.damage(damage_value)
			queue_free()