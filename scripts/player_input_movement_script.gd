class_name PlayerInputMovement
extends Node

@export var acceleration: float
@export var friction: float
@export var max_speed: float
@export var player_clone_controller: PlayerCloneController
@export var animated_sprite_2d: AnimatedSprite2D

var _character_body: CharacterBody2D

func _ready():
	_character_body = get_parent()

var input = Vector2.ZERO

func _process(_delta: float) -> void:
	if _character_body.velocity.length() > 0:
		animated_sprite_2d.play("run")
		player_clone_controller.set_clone_run()
	else:
		animated_sprite_2d.play("idle")
		player_clone_controller.set_clone_idle()

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if _character_body.velocity.length() > (friction * delta):
			_character_body.velocity -= _character_body.velocity.normalized() * (friction * delta)
		else:
			_character_body.velocity = Vector2.ZERO
			
	_character_body.velocity += input * acceleration * delta
	_character_body.velocity = _character_body.velocity.limit_length(max_speed)
	_character_body.move_and_slide()

	
