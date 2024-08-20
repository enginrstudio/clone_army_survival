class_name PlayerClone
extends CharacterBody2D

@export var animated_sprite_2d: AnimatedSprite2D

enum CLONE_STATE{IDLE,RUN}

var _state: CLONE_STATE = CLONE_STATE.IDLE
var _health: HealthComponent
var _health_label: HealthLabel

func _ready() -> void:
	_health = find_child("HealthComponent")
	_health.on_die.connect(Callable(
		self,
		"_handle_on_die",
	))
	_health.on_damage.connect(Callable(
		self,
		"_handle_on_damage"
	))

	_health_label = find_child("HealthLabel")
	
func _process(_delta: float) -> void:
	if _state == CLONE_STATE.RUN:
		animated_sprite_2d.play("run")
		
	if _state == CLONE_STATE.IDLE:
		animated_sprite_2d.play("idle")
		
func set_state_run():
	_state = CLONE_STATE.RUN

func set_state_idle():
	_state = CLONE_STATE.IDLE

func flip(val: bool):
	animated_sprite_2d.flip_h = val

func _handle_on_die():
	var clone_controller: PlayerCloneController = get_parent()
	var id:int = clone_controller._clones.find(self)
	clone_controller._clones.remove_at(id)
	queue_free()

func _handle_on_damage(remaining:int):
	_health_label.show_remaining_health(remaining)
